class ReportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def show
    @report = Report.find(params[:id])
  end

  def start
    @report = Report.new
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to @report
    else
      redirect_to new_report_path
    end
  end

  private
  def report_params
    params.require(:report).permit(:description).merge(user_id: current_user.id)
  end
end
