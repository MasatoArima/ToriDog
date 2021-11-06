class Customer::CustomersController < ApplicationController
  def index
    if current_customer.user_status == "dog_owner"
      @customers = Customer.where(user_status: 1).where(prefecture_code: current_customer.prefecture_code)
    else
      @customers = Customer.where(user_status: 0).where(prefecture_code: current_customer.prefecture_code)
    end
  end

  def mypage
    @myself = current_customer
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = current_customer
  end

  def update
    myself = current_customer
    if myself.update(customer_params)
      redirect_to customers_mypage_path, notice: '更新しました'
    else
      flash[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def withdraw_confirm
    @customer = current_customer
  end

  def withdraw
    customer = current_customer
    if customer.update(is_deleted: true)
      reset_session
      redirect_to root_path
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :prefecture_code, :city, :street, :other_address, :post_code, :phone_number, :introduction)
  end

end
