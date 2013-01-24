class CreateBuyPhotos < ActiveRecord::Migration
  def change
    create_table :buy_photos do |t|
      t.references :activity_image
      t.references :parent

      t.timestamps
    end
    add_index :buy_photos, :activity_image_id
    add_index :buy_photos, :parent_id
  end
end
