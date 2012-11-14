class TeamActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :team
  # attr_accessible :title, :body
end
