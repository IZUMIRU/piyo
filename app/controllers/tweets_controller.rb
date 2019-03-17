class TweetsController < ApplicationController
  require 'twitter'
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_twitter_client

  def top
    if user_signed_in?
      redirect_to new_tweet_path
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to @tweet
    else
      render :new
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

  def tweet_params
    params.require(:tweet).permit(:description).merge(user_id: current_user.id)
  end
end
