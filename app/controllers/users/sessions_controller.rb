class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render jsonapi: resource, class: { User: SerializableUser }, status: :ok
    else
      render json: { error: 'E-mail ou senha inválidos. Por favor, verifique suas credenciais.' }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if current_user
      head :no_content
    else
      render json: { error: 'Nenhum usuário autenticado para desconectar.' }, status: :unauthorized
    end
  end

  rescue_from StandardError do |exception|
    render json: { error: "Ocorreu um erro inesperado: #{exception.message}" }, status: :internal_server_error
  end
end
