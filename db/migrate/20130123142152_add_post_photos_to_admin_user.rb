class AddPostPhotosToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :post_photos, :boolean
  end
end
