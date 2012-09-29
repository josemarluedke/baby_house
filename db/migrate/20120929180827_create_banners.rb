class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.text :description
      t.string :link_text
      t.string :link_url
      t.boolean :visible

      t.timestamps
    end
    add_column :banners, :image, :oid
  end
end
