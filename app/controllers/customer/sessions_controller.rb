# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  before_action :reject_login, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def create
    cookies.signed[:customer_id] = current_customer.id
    redirect_to root_path
  end

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def reject_login
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password])
      if @customer.is_deleted == true
        flash[:alert] = "退会済みのアカウントです"
        redirect_to new_customer_session_path
      end
    else
      flash[:alert] = "メールアドレスもしくはパスワードが違います"
      redirect_to new_customer_session_path
    end
  end
end
