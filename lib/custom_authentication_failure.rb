class CustomAuthenticationFailure < Devise::FailureApp 
  protected
  def redirect_url
    # 自動でTwitter認証させる
    root_path+"users/auth/twitter"
  end
end
