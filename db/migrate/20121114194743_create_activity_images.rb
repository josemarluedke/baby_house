class CreateActivityImages < ActiveRecord::Migration
  def change
    create_table :activity_images do |t|
      t.references :activity, null: false

      t.timestamps
    end
    add_column :activity_images, :image, :oid, null: false
  end
end
