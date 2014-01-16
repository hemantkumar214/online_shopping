class Category < ActiveRecord::Base
	# category has many products 
	# each category has one parent
	# category also have image
	has_many :products
	has_many :subcategory, :class_name => "Category", :foreign_key => "parent_id"
  belongs_to :parentcategory, :class_name => "Category"
  has_attached_file :image, :default_url => "/images/default-product.png"
	
	searchable do
    text :name
  end
 
end
