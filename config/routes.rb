Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :users do
    get 'current_user', to: 'users#show'
  end

  resources :participants do
    collection do
      patch :confirm_presence
    end
  end
  
  namespace :admin do
    resources :courses
    resources :events
    resources :participants, only: [:index, :show, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
