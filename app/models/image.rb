class Image < ActiveRecord::Base
  attr_accessible :image, :description, :image_cache
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end
