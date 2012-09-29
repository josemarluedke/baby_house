class Image < ActiveRecord::Base
  attr_accessible :image, :description
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end
