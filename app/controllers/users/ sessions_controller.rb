# app/controllers/sessions_controller.rb
 
class Users::SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, :only => [:new]
  def create
    logger.info "Attempt to sign in by #{ params[:user][:email] }"
    @user = User.find_by_email(params[:user][:email])
    if @user != nil
      if !@user.is_portal_access?
        flash[:notice] = "#{ @user.email } do not have portal access."
        redirect_to :controller => 'welcome'
      else
        super
      end
    end
  end

  def destroy
    logger.info "#{ current_user.email } signed out"
    super
  end   
end

