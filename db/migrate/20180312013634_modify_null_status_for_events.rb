class ModifyNullStatusForEvents < ActiveRecord::Migration[5.1]
  def change
    change_column_null :event, :name, false
    change_column_null :event, :description, false
    change_column_null :event, :start_time, false
    change_column_null :event, :end_time, false
  end
end
