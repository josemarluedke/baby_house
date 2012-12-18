# Encoding: utf-8
class Team < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances
  has_many :team_activities
  has_many :activities, through: :team_activities

  attr_accessible :code, :name, :shift, :student_ids, :activity_ids, :code_year
  validates :code, :name, :shift, presence: true

  def before_import_save(row, map)
    self.shift = case self.shift
      when "1" then "Berçário"
      when "2" then "Minimaternal"
      when "3" then "Maternal I"
      else "Não definido"
    end
  end
end
