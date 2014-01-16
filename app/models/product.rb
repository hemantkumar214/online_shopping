class Product < ActiveRecord::Base
  # product belongs to one category and has many bills with many product details
  # product table has path of image
  belongs_to :category
  has_many :bills, :through => :bill_details
  has_many :product_details
  has_attached_file :image
  
  searchable do
		text :name
  end
end
