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
      generate_ogp
      # @twitter.update(@report.description)
      redirect_to @report
    else
      redirect_to new_report_path
    end
  end

  # OGP用の画像を生成する
  def generate_ogp
    base_image = Magick::Image.read(Rails.root.join('app/assets/images/ogp.png')).first

    if @report.description.present?
      draw = Magick::Draw.new
      # タイトルが14文字より多い場合、文字の真ん中で改行
      text = @report.description
      text.insert(text.length/2+1, "\n") if text.length > 14
      draw.annotate(base_image, 0, 0, 0, -50, text) do
        self.font      = Rails.root.join('app/assets/fonts/mplus-1p-bold.ttf').to_s
        self.fill      = 'black'
        self.stroke    = 'transparent'
        self.pointsize = 60
        self.gravity   = Magick::CenterGravity
      end
    end
    # 一旦tmpファイルとして保存
    ogp = Rails.root.join('tmp/images', "#{@report.id}.png")
    base_image.write(ogp)
    # Fileオブジェクトとして開く、画像の保存
    @report.ogp_image = File.open(ogp)
    @report.save!
    # tmpファイルの削除
    File.delete(File.open(ogp))
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
