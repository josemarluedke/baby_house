class BuyPhoto < ActiveRecord::Base
  belongs_to :activity_image
  belongs_to :parent
  attr_accessible :parent, :activity_image, :activity_image_id, :parent_id
  validates :activity_image, :parent, presence: true
  validates_uniqueness_of :activity_image_id, :scope => :parent_id
  PRICE = 10

  def self.price
    PRICE * count
  end
end
