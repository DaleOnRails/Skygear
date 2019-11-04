class Order < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :city
      t.string :state
      t.string :postcode
      t.string :phonenumber
      t.string :email

      t.timestamps
    end
  end
end
