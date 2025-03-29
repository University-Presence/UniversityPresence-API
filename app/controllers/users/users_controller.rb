module Users
  class UsersController < ApplicationController
    before_action :authenticate_user_with_jwt

    def show
      render jsonapi: current_user, class: { User: SerializableUser }, status: :ok
    end

    private

    def authenticate_user_with_jwt
      unless current_user
        render json: { error: 'Você precisa estar autenticado para acessar esta rota.' }, status: :unauthorized
      end
    end
  end
end
