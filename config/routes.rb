Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :event_users
  resources :events, path: 'fling'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
