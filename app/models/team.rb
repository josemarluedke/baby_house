class Team < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances

  attr_accessible :code, :name, :shift
  validates :code, :name, :shift, presence: true
end
