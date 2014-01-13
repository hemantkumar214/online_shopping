class AddressesController < ApplicationController
  def index
    #get all the adress in the index page
  	@addresses = Address.all
  end

  def new
    #to add new adress
  	@address = Address.new
  end

  def create
    #create the new address  
  	@address = Address.new(get_address_parameter)
    @address.user_id=current_user.id
    @address.save!
    if current_user.role_id==1
      redirect_to :addresses
    else
      redirect_to bills_create_path address_id: @address.id
    end
  end

  def show
  	@address = Address.find(params[:id])
  end

  def edit
  	@address = Address.find(params[:id])
  end

  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to addresses_path
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(get_address_parameter)
      redirect_to addresses_path, :notice => "Address has successfully updated"
    else
      render 'edit'
    end
  end

  private 
  def get_address_parameter 
  	params.require(:address).permit(:address, :landmark, :city, :state, :country, :pincode);
  end
end
