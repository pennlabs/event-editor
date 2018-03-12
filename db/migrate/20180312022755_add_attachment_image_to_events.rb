class AddAttachmentImageToEvents < ActiveRecord::Migration[4.2]
  def self.up
    change_table :event do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :event, :image
  end
end
