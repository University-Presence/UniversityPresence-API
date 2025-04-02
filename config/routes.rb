Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :users do
    get 'current_user', to: 'users#show'
  end

  patch '/participants/:event_id/confirm_presence', to: 'participants#confirm_presence', as: :confirm_presence_participants
  get '/participants/:event_id', to: 'participants#show_event', as: :show_event_participants

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
