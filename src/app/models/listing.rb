class Listing < ApplicationRecord
  has_one_attached :productimage

  validates :item, :price, :location, :description, presence: true
  validates :price, numericality: { greater_than: 0 }

  validate :image_presence
  validate :image_format

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
