class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title, :category_id
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :body, presence: true
  validates :title, uniqueness: true
  belongs_to :category

  auto_html_for :body do
    html_escape
    image
    youtube
    vimeo
    redcarpet
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
