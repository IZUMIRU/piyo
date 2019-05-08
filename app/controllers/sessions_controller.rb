class SessionsController < Devise::SessionsController
  def destroy
    super
    session[:keep_signed_out] = true
  end
end
