class TopsController < ApplicationController
  before_action :set_top, only: [:show, :edit, :update, :destroy]

  def index
    # ログインしていれば、通知設定ページにリダイレクト
    if user_signed_in?
      redirect_to user_root_path
    else
      @tops = Top.all
    end
  end
end
