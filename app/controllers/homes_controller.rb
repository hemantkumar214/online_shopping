class HomesController < ApplicationController
  def index
  	@categories = Category.all
  end

  def show  	
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to homes_path
  end
 
 # action for genearting bills;
  def generate_bill  
  end

  def user_details
    @user_details=User.includes(:addresses)
  end

  def subcategory
  	@category=Category.find_by_name(params[:id])
    @sub_categories = Category.includes(:products).where(parent_id: @category.id)
  end

  def category_product
    @category=Category.includes(:products).find_by_name(params[:id])
  end

  def product_info
    @product=Product.find_by_name(params[:id])
   end

  # function to update the session and add in cart
  def add_in_cart    
    product_id=params[:id].to_i
    total_request=1
    update_through_cart=0     
    if params.has_key?(:quant)     
      total_request=params[:quant][:total_request].to_i
      update_through_cart=1    
    end    
    if(check_availabilty(product_id,total_request,update_through_cart))
      update_session(product_id,total_request,update_through_cart)
    else
      flash[:notice] = "#{Product.find(product_id).name} is not available in this quantity"            
    end
  end

## checking the availabilty
  def check_availabilty(product_id,total_request=1,update_through_cart=0) 
    requested_product=0 
    requested_product += total_request    
    session[:temporary_shopping_cart].each do |product_hash|      
      if product_hash.keys[0].to_i==product_id.to_i
        if update_through_cart==0
          requested_product=product_hash.values[0].to_i+1
        end
        break        
      end
    end      
    available_product=ProductDetail.where(:product_id=>product_id, available: 1).count
    if requested_product > available_product      
      return false
    end
    return true
  end

  ## update the session
  def update_session(product_id,total_request,update_through_cart)
    if !session[:temporary_shopping_cart]
      session[:temporary_shopping_cart] =[]  
    end 
    flag=0 
    session[:temporary_shopping_cart].each do |product_hash| 
      if (product_hash.has_key?(product_id)) 
        flag=1
        if update_through_cart==0 
          product_hash[product_hash.keys[0]]=product_hash.values[0]+1
        else
          product_hash[product_hash.keys[0]]=total_request
        end
      end  
    end  
    if flag==0 
      session[:temporary_shopping_cart] << {product_id => 1}  
    end
  end
  helper_method :check_availabilty

  def search
    # code for searching category and display related content
    searching_keyword=params[:search]
    @search_products_result, @search_sub_cats, @search_cat_product, @search_products = HomesHelper.search_product_by_keyword(searching_keyword)    
  end
end
