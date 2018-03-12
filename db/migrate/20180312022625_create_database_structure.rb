class CreateDatabaseStructure < ActiveRecord::Migration[5.1]
  def change
    create_table 'event', force: :cascade do |t|
      t.text 'type', null: false
      t.text 'name', null: false
      t.text 'description', null: false
      t.text 'image_url', null: false, default: ''
      t.datetime 'start_time', null: false
      t.datetime 'end_time', null: false
    end
  end
end
