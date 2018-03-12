class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :event do |t|
      t.text :type
      t.text :name
      t.text :description
      t.text :image_url
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
