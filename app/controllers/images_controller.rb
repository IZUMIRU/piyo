class ImagesController < ApplicationController
  def ogp
    # 画像に表示させたいテキストを取得
    text = ogp_params[:text]
    # OgpCreatorが表示させたいテキストを追加した画像を作成。blobという形式で取得。
    image = OgpCreator.build(text).tempfile.open.read
    # blob形式の画像をpngファイルとしてレンダリング
    send_data image, :type => 'image/png',:disposition => 'inline'
  end

  def ogp_params
    params.permit(:text)
  end
end
