class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
