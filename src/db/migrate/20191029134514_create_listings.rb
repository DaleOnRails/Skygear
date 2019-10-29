class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :item
      t.decimal :price
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end