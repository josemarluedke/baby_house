class CreateParentStudents < ActiveRecord::Migration
  def change
    create_table :parent_students do |t|
      t.integer :parent_id, :null => false
      t.integer :student_id, :null => false
    end

    add_index :parent_students, :parent_id
    add_index :parent_students, :student_id
  end
end
