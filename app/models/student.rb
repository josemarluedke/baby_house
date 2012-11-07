class Student < ActiveRecord::Base
  attr_accessible :birthdate, :name
  validates :name, presence: true
end
