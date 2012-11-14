class Banner < ActiveRecord::Base
  attr_accessible :description, :link_text, :link_url, :title, :visible, :image, :image_cache
  validates :title, :link_url, :image, presence: true
  validates :link_url, format: { with: URI::regexp(%w[http https]) }
  mount_uploader :image, BannerUploader

  scope :visible, where(visible: true)

  def self.latest
    latest = where(visible: true).order("updated_at DESC").limit(1)
    latest.first
  end
end
