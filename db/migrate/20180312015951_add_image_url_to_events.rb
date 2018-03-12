class AddImageUrlToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :event, :image_url, :text, null: false, default: ''
  end
end
