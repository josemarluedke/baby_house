class AddCoverToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :cover, :oid
  end
end
