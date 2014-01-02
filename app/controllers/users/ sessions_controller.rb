# app/controllers/sessions_controller.rb
 
class Users::SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, :only => [:new]
  def create    
    super
  end
    
  def destroy
    logger.info "#{ current_user.email } signed out"
    super
  end   
end

