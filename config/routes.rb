Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :event_users
  scope ':type' do
    resources :events, path: '' do
      member do
        get :crop_preview
        post :crop
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
