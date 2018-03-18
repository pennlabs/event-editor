module EventsHelper
  def event_name
    case @type
    when 'fling'
      'Fling'
    else
      'Event'
    end
  end

  def event_item
    case @type
    when 'fling'
      'Performer'
    else
      'Item'
    end
  end
end
