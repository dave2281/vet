class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pagy::Backend
  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name surname])
  end
end
