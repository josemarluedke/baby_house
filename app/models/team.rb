# Encoding: utf-8
class Team < ActiveRecord::Base
  has_many :attendances
  has_many :students, through: :attendances
  has_many :team_activities
  has_many :activities, through: :team_activities

  attr_accessible :code, :name, :shift, :student_ids, :activity_ids, :code_year, :level
  validates :code, :name, :shift, :level, presence: true

  def before_import_save(row, map)
    self.level = case self.level
      when "1" then "Berçário"
      when "2" then "Minimaternal"
      when "3" then "Maternal I"
      when "4" then "Maternal II"
      when "5" then "Jardim I"
      when "6" then "Jardim II"
      else "Não definido"
    end
    self.shift = case self.shift
      when "Manh" then "Manhã"
    end
  end
end
