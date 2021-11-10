class Customer::CustomersController < ApplicationController
  before_action :setup, only: [:index, :mypage]

  def index
    @requests = Request.where(prefecture_code: current_customer.prefecture_code).page(params[:request_page]).per(5)
    if params[:q].blank? || params[:q][:prefecture_code_cont].blank?
      params[:q] = {}
      params[:q][:prefecture_code_cont] = current_customer.prefecture_code
    end

    if current_customer.user_status == "trimmer"
      @q = Customer.where(user_status: 0).ransack(params[:q])
      @r = Request.ransack(params[:q])
    else
      @q = Customer.where(user_status: 1).ransack(params[:q])
    end

    unless params[:q].nil?
      if params[:q][:s].blank?
        trimmers = Customer.where(user_status: 1).where("prefecture_code like '%#{params[:q][:prefecture_code_cont]}%'").includes(:likers).sort {|a,b| b.likers.size <=> a.likers.size}
        @trimmers = Kaminari.paginate_array(trimmers).page(params[:customer_page]).per(5)
        @dog_owners = @q.result(distinct: true).page(params[:customer_page]).per(5)
      else
        @trimmers = @q.result(distinct: true).page(params[:customer_page]).per(5)

      end
    end
  end

  def mypage
    @customer = current_customer
    @requests = Request.all
  end

  def show
    @customer = Customer.find(params[:id])
    @dogs = Dog.where(customer_id: @customer.id)
    @requests = Request.all
    @applications = Application.all
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
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :prefecture_code, :city, :street, :other_address, :post_code, :phone_number, :introduction, :profile_image, cut_images: [])
  end

  def setup
    @customers = Customer.all
    @trimmers = Customer.where(user_status: 1).where(prefecture_code: current_customer.prefecture_code).page(params[:customer_page]).per(5)
    @dog_owners = Customer.where(user_status: 0).where(prefecture_code: current_customer.prefecture_code).page(params[:customer_page]).per(5)
    @dogs = Dog.all
    @applications = Application.all
    @contracts = Contract.all.page(params[:contract_page]).per(5)
  end

end
