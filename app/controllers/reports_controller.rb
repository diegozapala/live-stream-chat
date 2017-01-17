class ReportsController < ApplicationController

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def create
    @report = Report.new()

    build_report

    if @report.save
      redirect_to report_path(@report)
    else
      flash[:alert] = "Houve algum problema! Por favor, tente novamente."
      redirect_to root_path
    end
  end

  private

  def build_report
    return unless current_chat.present?

    @report.number_accesses = current_chat.number_accesses
    @report.number_messages_sent = current_chat.total_messages
    @report.live_stream = current_live_stream
  end

end
