class Team < ActiveRecord::Base
  attr_accessible :code, :name, :shift
  validates :code, :name, :shift, presence: true
end
