class AddCodeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :code, :string
  end
end
