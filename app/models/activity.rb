class Activity < ActiveRecord::Base
  has_many :team_activities
  has_many :teams, through: :team_activities

  attr_accessible :date, :description, :name, :team_ids
  validates :name, presence: true
end
