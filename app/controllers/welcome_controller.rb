class WelcomeController < ApplicationController
  def index
    if event_user_signed_in?
      redirect_to events_path('fling')
    else
      redirect_to new_event_user_session_path
    end
  end
end
