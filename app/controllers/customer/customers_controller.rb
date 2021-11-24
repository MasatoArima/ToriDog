class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def index
    # @customers = Customer.all
    @customers = Customer.includes(:profile_image_attachment)
    if current_customer.user_status == "trimmer"
      @dog_owners = Customer.where(user_status: 0).where(prefecture_code: current_customer.prefecture_code).page(params[:customer_page]).per(5).includes([:dogs]).includes([:profile_image_attachment])
      @requests = Request.where(prefecture_code: current_customer.prefecture_code, is_complete: "false").page(params[:request_page]).per(5)
      @applications = current_customer.applications
      @dogs = Dog.all
      @q = Customer.left_joins(:dogs).where(user_status: 0).ransack(params[:q])
      unless params[:q].nil?
        @q.result(distinct: true).page(params[:customer_page]).per(5)
        @dog_owners = @q.result(distinct: true).page(params[:customer_page]).per(5)
        requests = []
        @dog_owners.each do |dog_owner|
          requests.append(dog_owner.requests.where(is_complete: "false"))
        end
        if requests.sum() == 0
          requests = []
        else
          requests.sum()
        end
        # binding.pry
        @requests =Kaminari.paginate_array(requests.sum()).page(params[:request_page]).per(5)
        # @requests =Kaminari.paginate_array(requests.sum()).page(params[:request_page]).per(5)
      end
    else
      @map_trimmers = Customer.where(user_status: 1)
      trimmers = Customer.includes(:profile_image_attachment).where(user_status: 1).where(prefecture_code: current_customer.prefecture_code).sort { |a, b| b.likers.size <=> a.likers.size }
      @trimmers = Kaminari.paginate_array(trimmers).page(params[:customer_page]).per(5)
      @q = Customer.left_joins(:info).where(user_status: 1).ransack(params[:q])
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
    if Info.find_by(customer_id: @customer.id).nil?
      @info = Info.new(customer_id: @customer.id)
      @info.save
      @customer.update(info_id: @info.id)
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
    @info = Info.find_by(customer_id: @customer.id)
  end

  def update
    @customer = current_customer
    @info = Info.find_by(customer_id: @customer.id)
    if Geocoder.search(@customer.open_addres).blank?
      if @customer.update(customer_params)
        if @customer.user_status == "trimmer"
          @info.update(trimmer_info_params[:info])
        end
        @customer.update(lat: nil, lng: nil)
        redirect_to customers_mypage_path, notice: '更新しました'
      else
        flash[:alert] = '更新に失敗しました'
        redirect_to request.referer
      end
    else
      lat = Geocoder.search(@customer.open_addres).first.coordinates[0]
      lng = Geocoder.search(@customer.open_addres).first.coordinates[1]
      if @customer.update(customer_params)
        if @customer.user_status == "trimmer"
          @info.update(trimmer_info_params[:info])
        end
        @customer.update(lat: lat, lng: lng)
        redirect_to customers_mypage_path, notice: '更新しました'
      else
        flash[:alert] = '更新に失敗しました'
        redirect_to request.referer
      end
    end
  end

  def withdraw_confirm
    @customer = current_customer
  end

  def withdraw
    customer = current_customer
    if customer.update(is_deleted: true) && customer.update(lat: nil, lng: nil)
      reset_session
      redirect_to root_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :prefecture_code, :city, :street, :other_address, :post_code, :phone_number, :introduction, :profile_image, :lat, :lng, cut_images: [])
  end

  def trimmer_info_params
    params.require(:customer).permit(info: [:customer_id, :best_breed, :best_cut, :price_large, :price_medium, :price_small])
  end

end
