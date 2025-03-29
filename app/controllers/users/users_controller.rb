module Users
  class UsersController < ApplicationController
    before_action :authenticate_user_with_jwt

    def show
      render jsonapi: current_user, class: { User: SerializableUser }, status: :ok
    end
  end
end
