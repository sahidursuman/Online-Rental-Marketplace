class RemoveTitleFromPhotos < ActiveRecord::Migration
  def change
  	remove_column :photos, :title
  end
end
