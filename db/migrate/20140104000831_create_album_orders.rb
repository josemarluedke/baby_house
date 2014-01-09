class CreateAlbumOrders < ActiveRecord::Migration
  def change
    create_table :album_orders do |t|
      t.references :parent
      t.datetime :finished_at
      t.boolean :exported, default: false
      t.string :filename, default: ''

      t.timestamps
    end
    add_index :album_orders, :parent_id

    add_column :buy_photos, :album_order_id, :integer
    add_index :buy_photos, :album_order_id
  end

  def migrate(direction)
    super
    if direction == :up
      BuyPhoto.all.each do |buy_photo|
        album = AlbumOrder.find_or_create_by_parent_id(buy_photo.parent.id)
        buy_photo.update_attribute(:album_order_id, album.id)
      end
    end
  end
end
