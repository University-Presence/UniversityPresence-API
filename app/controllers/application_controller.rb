class ApplicationController < ActionController::API
  before_action :authenticate_scope!

  private

  def authenticate_scope!
    if request.path.start_with?('/admin')
      authenticate_admin_user!
    else
      authenticate_user!
    end
  end
end
