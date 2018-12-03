class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def top
    if user_signed_in?
      notification = Notification.find_by(user_id: current_user.id)
      if notification.blank?
        redirect_to notifications_set_path
      end
    else
      render :twitter_login
    end
  end

  def set
    @notification = Notification.find_by(user_id: current_user.id)
    if @notification.blank?
      @notification = Notification.new
    end
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to :root
    else
      render :set
    end
  end

  def update
    @notification = Notification.find_by(user_id: current_user.id)
    if @notification.update(notification_params)
      redirect_to :root
    else
      render :set
    end
  end

  # def destroy
  #   notification = Notification.find(params[:id])
  #   notification.destroy if notification.user_id == current_user.id
  #   redirect_to notifications_path(id: notification.id)
  #   flash[:notice] = "通知を止めました。"
  # end

  private
  def notification_params
    params.require(:notification).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :time).merge(user_id: current_user.id)
  end
end
