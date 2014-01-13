module HomesHelper
	def get_parent_name(id)
		Category.find(id).name rescue nil
	end

	def self.search_product_by_keyword(searching_keyword)
		@search_products_result = []
    @search_sub_cats = nil
    @search_cat_product = nil
    @search_products = nil

		@search_categories = Category.search do
      fulltext (searching_keyword).strip
    end

    if @search_categories
      @result_categories_result = @search_categories.results
      @result_categories_result.each do |cat_id|
        @srch_cat_id = cat_id
      end

      if @srch_cat_id
        @search_sub_cats = Category.where(parent_id: @srch_cat_id)
        @child_categories = Category.where('id not in(?)', Category.all.map(&:parent_id)- [nil]).to_a
        @child_categories.each do |child_category|
          if child_category == @srch_cat_id
            @search_cat_product = @srch_cat_id
          end
        end
        if @search_cat_product
          cat_id=Category.find_by_name(@search_cat_product.name).id
          @search_products = Product.where(category_id: cat_id)
        else
          @search_cat_product = nil
          @search_products = nil
        end
      end
    end
    #code for searching products 
    @srch_products = Product.search do
      fulltext (searching_keyword).strip
    end
    if @srch_products
      @search_products_result = @srch_products.results
    end
    p @search_products_result
    p "====================="
    p @search_sub_cats
    p "222222222222222222222222"
    p @search_cat_product
    p "---------------------"
    p @search_products
    p "++++++++++++++++++++"
    
    return [@search_products_result, @search_sub_cats, @search_cat_product, @search_products]
	end
end
