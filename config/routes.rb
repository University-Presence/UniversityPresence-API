Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :users do
    get 'current_user', to: 'users#show'
  end

  namespace :admin do
    resources :courses
    resources :events
    resources :courses do
      resources :class_rooms do
        resources :students
      end
    end
  end
end
