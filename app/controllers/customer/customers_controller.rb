class Customer::CustomersController < ApplicationController
  def index
    # @customers = Customer.all
    @customers = Customer.includes(:profile_image_attachment)
    if current_customer.user_status == "trimmer"
      @dog_owners = Customer.where(user_status: 0).where(prefecture_code: current_customer.prefecture_code).page(params[:customer_page]).per(5)
      @requests = Request.where(prefecture_code: current_customer.prefecture_code, is_complete: "false").page(params[:request_page]).per(5)
      @applications = current_customer.applications
      @dogs = Dog.all
      @q = Customer.where(user_status: 0).ransack(params[:q])
      unless params[:q].nil?
        @q.result(distinct: true).page(params[:customer_page]).per(5)
         @dog_owners = @q.result(distinct: true).page(params[:customer_page]).per(5)
      end
    else
      @map_trimmers = Customer.where(user_status: 1)
      # @map_trimmers = Customer.where(user_status: 1)
      trimmers = Customer.includes(:profile_image_attachment).where(user_status: 1).where(prefecture_code: current_customer.prefecture_code).sort { |a, b| b.likers.size <=> a.likers.size }
      # trimmers = Customer.includes(:profile_image_attachment).where(user_status: 1).where(prefecture_code: current_customer.prefecture_code).sort {|a,b| b.likers.size <=> a.likers.size}
      # trimmers = Customer.where(user_status: 1).where(prefecture_code: current_customer.prefecture_code).sort {|a,b| b.likers.size <=> a.likers.size}
      @trimmers = Kaminari.paginate_array(trimmers).page(params[:customer_page]).per(5)
      @q = Customer.where(user_status: 1).ransack(params[:q])
      unless params[:q].nil?
        trimmers = @q.result(distinct: true).sort { |a, b| b.likers.size <=> a.likers.size }
        @trimmers = Kaminari.paginate_array(trimmers).page(params[:customer_page]).per(5)
      end
    end
  end

  def mypage
    @customers = Customer.all
    @evaluations = Evaluation.all
    @customer = current_customer
    if current_customer.user_status == "trimmer"
      @contracts = current_customer.trimmer_contract.page(params[:contract_page]).per(5).order(id: :DESC)
      @requests = Request.all
      @applications_page = current_customer.applications.where(contract_id: nil).page(params[:application_page]).per(5).order(id: :DESC)
      @applications = current_customer.applications
      @dogs = Dog.all
    else
      @contracts = current_customer.client_contract.page(params[:contract_page]).per(5).order(id: :DESC)
      @requests = current_customer.requests
      @applications = Application.all
      @dogs = current_customer.dogs
    end

  end

  def show
    @customer = Customer.find(params[:id])
    @dogs = @customer.dogs
    @requests = @customer.requests
    @contracts = @customer.trimmer_contract
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

end
