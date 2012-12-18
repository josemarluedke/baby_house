class AddCodeYearToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :code_year, :string
  end
end
