class Listing < ApplicationRecord
  has_one_attached :productimage
  belongs_to :user
  # belongs_to :wishlist
  # Second hand marketplaces such as gumtree typically only sell individual items
  has_one :order

  validates :item, :price, :location, :description, presence: true
  validates :price, numericality: { greater_than: 0 }

  validate :image_presence
  validate :image_format

  #Scope methods
  #Scope methods (sort_by_price) are named class method for retrieving and querying objects, with a corresponding route.
  # scope :sort_by_price, -> { order("price ASC") }

  private

  def image_presence
    if productimage.attached? == false
      errors.add :productimage, "Image can't be blank"
    end
  end

  def image_format
    return unless productimage.attached?
    return if productimage.blob.content_type.start_with? "image/"
    productimage.purge_later
    errors.add :productimage, "Wrong format"
  end
end
