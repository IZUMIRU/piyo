class ReportsController < ApplicationController
  require 'twitter'
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :set_twitter_client

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
      # @twitter.update(@report.description)
      redirect_to @report
    else
      redirect_to new_report_path
    end
  end

  private
  def set_twitter_client
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:api_secret]
      config.access_token        = Rails.application.credentials.twitter[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
    end
  end

  def report_params
    params.require(:report).permit(:description).merge(user_id: current_user.id)
  end
end
