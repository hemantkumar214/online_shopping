module HomesHelper
	def get_parent_name(id)
		Category.find(id).name rescue nil
	end

	def self.search_keyword(searching_keyword)
    # this code will search categories, if searched keyboard belongs to it.
    @search_categories = Category.search do
      fulltext (searching_keyword).strip
    end
    @category_results = @search_categories.results

    # this code will search categories, if searched keyboard belongs to it.
    @search_products = Product.search do
      fulltext (searching_keyword).strip
    end
    @product_results = @search_products.results
    return [@category_results, @product_results]
  end
  
end
