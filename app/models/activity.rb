class Activity < ActiveRecord::Base
  has_many :team_activities
  has_many :teams, through: :team_activities
  has_many :activity_images

  attr_accessible :date, :description, :name, :cover, :cover_cache, :team_ids, :activity_image_ids
  mount_uploader :cover, CoverUploader

  validates :name, :cover, presence: true
end
