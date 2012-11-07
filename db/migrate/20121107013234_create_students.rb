class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name, :null => false, :default => ""
      t.date :birthdate

      t.timestamps
    end
  end
end
