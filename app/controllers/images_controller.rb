class ImagesController < ApplicationController
  def ogp
    # 投稿時間をKey、OGPに表示するテキストをValueとしてハッシュで取得
    @reports = {}
    Report.where(user_id: current_user.id).each do |report|
      @reports.merge!(report.created_at.strftime('%Y-%m-%d %H:%M:%S') => report.description)
    end



    # 表示するテキストを追加したOGPをblob形式で取得。
    image = OgpCreator.build(text).tempfile.open.read

    # blob形式の画像をpngファイルとしてレンダリング
    send_data image, :type => 'image/png',:disposition => 'inline'
  end
end
