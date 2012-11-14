class Activity < ActiveRecord::Base
  attr_accessible :date, :description, :name
  validates :name, presence: true
end
