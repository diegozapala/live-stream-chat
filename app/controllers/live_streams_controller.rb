class LiveStreamsController < ApplicationController

  def index
    @live_streams = LiveStream.all
  end

  def show
    @live_stream = LiveStream.find_by(id: params[:id])
  end

end
