class Banner < ActiveRecord::Base
  attr_accessible :description, :link_text, :link_url, :title, :visible, :image
  validates :title, :description, :link_text, :link_url, :image, presence: true
  validates :link_url, format: { with: URI::regexp(%w[http https]) }
  mount_uploader :image, BannerUploader

  scope :visible, where(visible: true)
end
