class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :body, presence: true
  validates :title, uniqueness: true

  auto_html_for :body do
    html_escape
    image
    youtube
    vimeo
    redcarpet
    link target: "_blank"
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
