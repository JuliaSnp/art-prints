class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    
    #all the data about a single product
    
    create_table :products do |t|
      t.string :title
      t.string :artist
      t.string :category
      t.string :image_url
      t.decimal :price, precision: 6, scale: 2
      #6 digits before the dot, 2 after
      t.string :tag1
      t.string :tag2
      t.string :tag3
      t.string :tag4

      t.timestamps
    end
  end
end
