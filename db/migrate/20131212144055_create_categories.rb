class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
     
      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
