class BuyPhoto < ActiveRecord::Base
  belongs_to :activity_image
  belongs_to :parent
  belongs_to :album_order
  attr_accessible :parent, :activity_image, :activity_image_id, :parent_id
  validates :activity_image, :parent, :album_order, presence: true
  validates_uniqueness_of :activity_image_id, :scope => [:parent_id, :album_order_id]
  PRICE = 10

  def self.price
    PRICE * count
  end
end
