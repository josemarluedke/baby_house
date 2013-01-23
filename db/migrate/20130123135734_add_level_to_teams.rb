class AddLevelToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :level, :string
  end
end
