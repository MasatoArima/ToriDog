class Admin::CustomersController < ApplicationController
  def index
    @torimmers = Customer.where(user_status: 1)
    @dog_owners = Customer.where(user_status: 0)
  end

  def show
    @customer = Customer.find(params[:id])
  end


  def edit
    @customer = Customer.find(params[:id])
  end


  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :prefecture_code, :city, :street, :other_address, :post_code, :phone_number, :introduction, :is_deleted)
  end


end
