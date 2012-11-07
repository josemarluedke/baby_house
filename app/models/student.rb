class Student < ActiveRecord::Base
  has_many :parent_students
  has_many :parents, through: :parent_students

  attr_accessible :birthdate, :name, :parent_ids
  validates :name, presence: true
end
