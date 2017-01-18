class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_live_stream
    @live_stream || LiveStream.find_by(id: params[:live_stream_id])
  end

  def current_chat
    return unless current_live_stream.present?
    Chat.new(live_stream: current_live_stream)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

end
