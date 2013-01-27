class AddOrifinalFilenameToActivityImages < ActiveRecord::Migration
  def change
    add_column :activity_images, :original_filename, :string
  end
end
