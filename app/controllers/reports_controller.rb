class ReportsController < ApplicationController

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def create
    @report = Report.new(number_accesses: current_chat.number_accesses,
                         number_messages_sent: current_chat.total_messages,
                         live_stream: current_live_stream)

    redirect_to report_path(@report)
  end

end
