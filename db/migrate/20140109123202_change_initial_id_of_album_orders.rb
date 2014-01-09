class ChangeInitialIdOfAlbumOrders < ActiveRecord::Migration
  def up
    execute("ALTER SEQUENCE album_orders_id_seq START with 100 RESTART;")
  end

  def down
    execute("ALTER SEQUENCE album_orders_id_seq START with 1 RESTART;")
  end
end
