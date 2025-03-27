# frozen_string_literal: true

module Admin
  class Users::SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      if current_user
        token = request.env['warden-jwt_auth.token']
        render json: { message: 'Logged in successfully', user: resource, token: token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    def respond_to_on_destroy
      if current_user
        head :no_content
      else
        render json: { error: 'Not logged in' }, status: :unauthorized
      end
    end
  end
end
