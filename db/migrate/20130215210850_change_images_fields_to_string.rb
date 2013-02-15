class ChangeImagesFieldsToString < ActiveRecord::Migration
  def up
    change_column :activities, :cover, :string
    change_column :banners, :image, :string
    change_column :images, :image, :string
    change_column :activity_images, :image, :string
  end

  def down
    change_column :activities, :cover, :oid
    change_column :banners, :image, :oid
    change_column :images, :image, :oid
    change_column :activity_images, :image, :oid
  end
end
