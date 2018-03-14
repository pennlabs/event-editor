json.extract! event, :id, :type, :name, :description, :image_url, :start_time, :end_time
json.url event_url(event, format: :json)
