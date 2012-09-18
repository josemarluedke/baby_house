class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :body
      t.string :slug

      t.timestamps
    end
    add_index :pages, :title
    add_index :pages, :slug
  end
end
