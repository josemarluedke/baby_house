class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :shift, null: false

      t.timestamps
    end
  end
end
