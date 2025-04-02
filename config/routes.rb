Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :users do
    get 'current_user', to: 'users#show'
  end

  resources :participants do
    patch ':event_id/confirm_presence', to: 'participants#confirm_presence', on: :collection, as: :confirm_presence
    patch ':event_id', to: 'participants#show_event', on: :collection, as: :show_event
  end

  namespace :admin do
    resources :courses
    resources :events do
      resources :participants, only: [:index, :show, :destroy]
    end
    resources :courses do
      resources :class_rooms do
        resources :students
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
