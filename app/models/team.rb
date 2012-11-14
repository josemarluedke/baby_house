class Team < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances
  has_many :team_activities
  has_many :activities, through: :team_activities

  attr_accessible :code, :name, :shift, :student_ids, :activity_ids
  validates :code, :name, :shift, presence: true
end
