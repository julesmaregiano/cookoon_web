class ApplicationController < ActionController::Base
  if Rails.env.staging?
    http_basic_authenticate_with name: ENV["HTTP_AUTH_NAME"], password: ENV["HTTP_AUTH_PASSWORD"]
  end
  
  protect_from_forgery with: :exception
end
