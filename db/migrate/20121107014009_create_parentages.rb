class CreateParentages < ActiveRecord::Migration
  def change
    create_table :parentages do |t|
      t.references :parent, null: false
      t.references :student, null: false
    end

    add_index :parentages, :parent_id
    add_index :parentages, :student_id
  end
end
