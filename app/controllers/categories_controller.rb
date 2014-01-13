class CategoriesController < ApplicationController
  def index
    #to display all the categories in the index page    
    @categories = Category.all       
  end

  def new
    #to add new category
    @category=Category.new
  end
  def show
    @category = Category.find(params[:id])
  end

  def create
    @category=Category.new(get_category_parameter).save!      
    #redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    @categories = Category.all
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(get_category_parameter)
      #redirect_to categories_path, :notice => "Category has successfully updated"
    else
     render 'edit'
    end
  end

  private 
  def get_category_parameter 
    params.require(:category).permit(:name, :parent_id, :image);
  end
end