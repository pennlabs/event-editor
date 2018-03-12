class RemoveImageUrlFromEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :event, :image_url, :text
  end
end
