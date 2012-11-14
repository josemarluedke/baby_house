class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :team, null: false
      t.references :student, null: false
    end
    add_index :attendances, :team_id
    add_index :attendances, :student_id
  end
end
