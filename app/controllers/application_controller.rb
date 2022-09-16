class ApplicationController < ActionController::Base
  require 'gravtastic'
  before_action :authenticate_user!, except: [:about, :not_found, :internal_server, :unprocessable]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  private

  def send_welcome_email
    UserMailer.with(user: @user).welcome_email.deliver_now
  end
end
