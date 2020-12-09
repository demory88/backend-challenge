class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    # We're going to run this every time after they sign in to keep their tags current if they update their website
    Thread.new{User.scrape_tags(resource)}
    return root_path
   end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :url, :short_url, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :url, :short_url, :email, :password, :current_password) }
  end
end
