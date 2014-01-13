class ProductsController < ApplicationController
  def index
    @products = Product.all    
  end

  def new
    @product = Product.new
  end

  def show
   @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(get_product_parameter).save!
    #redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    @products = Product.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(get_product_parameter)
     # redirect_to products_path, :notice => "Product has successfully updated"
    else
     # render 'edit'
    end
  end

  private
  def get_product_parameter
    params.require(:product).permit(:category_id, :name, :description, :price, :image)
  end
end