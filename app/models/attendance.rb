class Attendance < ActiveRecord::Base
  belongs_to :team
  belongs_to :student
  # attr_accessible :title, :body
end
