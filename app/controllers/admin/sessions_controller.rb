# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  attr_reader :user, :password, :email
  before_action :sign_in_params, only: [:create]
  def create
    @password = params["user"]["password"]
    @email = params["user"]["email"]
    successful_callback = lambda do |caller|
      sign_in caller, store: false
      render jsonapi: caller, status: :ok,
             include: include_options, fields: fields_options
    end

    load_user
    byebug
    return successful_callback.call(user) if password_validation
  end

  private

  def password_validation
    byebug
    return if user&.valid_for_authentication? { user&.valid_password?(password) }

    "error"
  end

  def load_user
    @user = User.find_for_database_authentication(email: email)
  end

  def respond_to_on_destroy
    head :no_content
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
