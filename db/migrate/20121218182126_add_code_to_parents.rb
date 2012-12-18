class AddCodeToParents < ActiveRecord::Migration
  def change
    add_column :parents, :code, :string
  end
end
