# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in @user, event: :authentication
    Rails.logger.debug("#{@user}kokomite")
    set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    redirect_to search_datas_path
  end

  def failure
    flash[:alert] = "ログインに失敗しました"
    redirect_to root_path
  end
end
