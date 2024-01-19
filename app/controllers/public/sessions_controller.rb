# frozen_string_literal: true

# 顧客側のサインアップに関する機能
class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  #ログイン時の画面遷移先
  def after_sign_in_path_for(resource)
    root_path
  end

  #ログアウト時の画面遷移先
  def after_sign_out_path_for(resource)
    new_registration_path(resource_name)
  end

end
