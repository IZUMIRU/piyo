class ReportsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :update, :destroy]

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to :root
    else
      render :set
    end
  end

  private
  def report_params
    params.require(:report).permit(:title, :description).merge(user_id: current_user.id)
  end
end
