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

    if @report.save
      redirect_to report_path(@report)
    else
      flash[:alert] = "Houve algum problema! Por favor, tente novamente."
      redirect_to root_path
    end
  end

end
