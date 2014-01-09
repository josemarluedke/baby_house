class AddDownloadUrlToAlbumOrders < ActiveRecord::Migration
  def change
    add_column :album_orders, :download_url, :string, default: ""
  end
end
