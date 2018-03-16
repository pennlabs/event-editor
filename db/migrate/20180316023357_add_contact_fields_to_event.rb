class AddContactFieldsToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :event, :website, :string
    add_column :event, :facebook, :string
    add_column :event, :email, :string
  end
end
