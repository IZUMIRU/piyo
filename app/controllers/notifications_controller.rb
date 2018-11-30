class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to @notification
      flash[:notice] = '通知時間を設定できました。'
    else
      flash[:notice] = '通知時間を設定できませんでした。'
      render :new
    end
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy if notification.user_id == current_user.id
    redirect_to notifications_path(id: notification.id)
    flash[:notice] = "通知を止めました。"
  end

  private
  def notification_params
    params.require(:notification).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :time).merge(user_id: current_user.id)
  end
end
