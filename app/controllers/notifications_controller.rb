class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if user_signed_in?
      redirect_to notifications_finish_path
    end
  end

  def set
    notification = Notification.find_by(user_id: current_user.id)
    if notification.blank?
   @notification = Notification.new
    if @notification.present?

    end
  end

  def finish
    notification = Notification.find_by(user_id: current_user.id)
    if notification.blank?
      redirect_to notifications_set_path
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
