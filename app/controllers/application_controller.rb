class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  if Rails.env.staging?
    http_basic_authenticate_with name: ENV["HTTP_AUTH_NAME"], password: ENV["HTTP_AUTH_PASSWORD"]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name])
  end

  def current_search
    return unless current_user
    @current_search ||= current_user.last_recent_search
  end

  # disable devises flashes
  def is_flashing_format?
    false
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
