class BillDetail < ActiveRecord::Base
	# bill detail belongs to one bill
	# bill detail belogns to one product
	# bill detail belongs to one product detail
	belongs_to :bill
	belongs_to :product
	belongs_to :product_detail

	def self.create_bill_detail_foreach_product(product_hash,bill_id)
		total_amount=0;
		product_id=product_hash.keys[0]
    @product = Product.find(product_id)               
    @product_detail_array = ProductDetail.where(product_id: product_id, available: 1).limit(product_hash.values[0]).to_a
    @product_detail_array.each do |product_detail|
      total_amount += @product.price
      product_detail.available=0
      product_detail.save      
      product_detail_id=product_detail.id      
      @bill_detail = BillDetail.new(price: @product.price, bill_id: bill_id , product_id: @product.id, product_detail_id: product_detail_id)
      @bill_detail.save      
    end
    return total_amount      
	end
end
