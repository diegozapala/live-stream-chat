class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def current_live_stream
    @live_stream || LiveStream.find_by(id: params[:live_stream_id])
  end

  def current_chat
    return unless current_live_stream.present?
    Chat.new(live_stream: current_live_stream)
  end

end
