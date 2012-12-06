class RemoveLinkTextFromBanners < ActiveRecord::Migration
  def change
    remove_column :banners, :link_text
  end
end
