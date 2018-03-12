json.extract! event, :id, :type, :name, :description, :image_url, :start_time, :end_time, :created_at, :updated_at
json.url event_url(event, format: :json)
