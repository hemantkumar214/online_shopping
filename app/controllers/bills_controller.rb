class BillsController < ApplicationController
  def index
    if current_user.role_id==1
  	@bills=Bill.includes(:user)
  else
    @bills=Bill.where(user_id: current_user.id)
  end
end
  def new  	
  end
  # action to create bill with bill details 
  def create
    @bill = Bill.new(user_id: current_user.id, date: Time.now, address_id: params[:address_id])   
    if @bill.save
      total_amount=0
      session[:temporary_shopping_cart].each do |product_hash|
        total_amount += BillDetail.create_bill_detail_foreach_product(product_hash,@bill.id)                      
      end
      @bill.total_amount=total_amount
      @bill.save!
      session[:temporary_shopping_cart]=[]      
      redirect_to bills_show_path :id => @bill.id 
    end    
  end
  # action for deleting bill
  def destroy
    @bill=Bill.find(params[:id])
  	@bill.destroy
    if current_user.role_id==1
      @bills=Bill.all
    else
      @bills=Bill.where(user_id: current_user.id)
    end    
  end

  def show
    @bill=Bill.find(params[:id])    
    @address=Address.find(@bill.address_id)    
  end 

end
