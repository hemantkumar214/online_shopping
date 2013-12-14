class CategoriesController < ApplicationController
  def index
  	@categories = Category.all
  end

  def new
  	@category=Category.new
  end

  def show
  	@category = Category.find(params[:id])
  end

  def create
  		@category=Category.new(get_category_parameter).save!
    	redirect_to :categories
  end

  def edit
  	@category = Category.find(params[:id])
  end

  def destroy
  	@category = Category.find(params[:id])
  	@category.destroy
  	redirect_to categories_path
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(get_category_parameter)
      redirect_to categories_path, :notice => "Category has successfully updated"
    else
      render 'edit'
    end
  end

  private 
  def get_category_parameter 
  	params.require(:category).permit(:name, :parent_id);
  end
end
