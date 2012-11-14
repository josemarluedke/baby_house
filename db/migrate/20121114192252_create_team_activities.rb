class CreateTeamActivities < ActiveRecord::Migration
  def change
    create_table :team_activities do |t|
      t.references :activity, null: true
      t.references :team, null: false

      t.timestamps
    end
    add_index :team_activities, :activity_id
    add_index :team_activities, :team_id
  end
end
