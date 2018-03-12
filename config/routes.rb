Rails.application.routes.draw do
  devise_for :event_users
  root :to => redirect('/fling')
  resources :events, path: 'fling'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
