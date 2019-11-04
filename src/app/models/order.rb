class Order < ApplicationRecord
  #validates all fields except phone-number incase the user doesn't have one
  validates :address, :city, :state, :name, :postcode, :email, presence: true

  # Links the order to the Listing
  belongs_to :listing

  # Tells rails that an order is connected between both the buyer and seller
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
end
