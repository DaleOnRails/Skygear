class User < ApplicationRecord
  has_many :listings, dependent: :destroy

  # Users will have orders they purchased and orders they sold
  # 'foreign_key' tells rails to use the seller_id to identify which user sold the item.
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ensures users cannot sign up with a blank name field
  validates :name, presence: true
end
