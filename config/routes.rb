Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :event_users
  scope ':type' do
    resources :events, path: ''
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
