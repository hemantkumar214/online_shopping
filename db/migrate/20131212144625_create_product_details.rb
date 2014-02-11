class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.integer :unique_id
      t.boolean :available, :default => true
      t.belongs_to :product
      
      t.timestamps
    end
  end
end
