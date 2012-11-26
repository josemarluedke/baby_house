class Activity < ActiveRecord::Base
  has_many :team_activities
  has_many :teams, through: :team_activities
  has_many :activity_images

  attr_accessible :date, :description, :name, :cover, :cover_cache, :team_ids, :activity_image_ids
  mount_uploader :cover, CoverUploader

  validates :name, :cover, presence: true

  def can_see_activity(current_parent)
    teams.each do |team|
      team.students.each do |student|
        return true if student.parents.include? current_parent
      end
    end
    false
  end

  scope :parent_activities, ->(current_parent){ all.map { |activity| activity if activity.can_see_activity(current_parent)} }
end
