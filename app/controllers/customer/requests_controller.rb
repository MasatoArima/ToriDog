class Customer::RequestsController < ApplicationController
  def show
    @contracts = Contract.all
    @request = Request.find(params[:id])
    @customer = Customer.find_by(id: @request.customer_id)
    @dog = Dog.find_by(id: @request.dog_id)
    @application = Application.find_by(customer_id: current_customer.id, request_id: @request.id)
    @applications = Application.where(request_id: @request.id)

    if @application.nil?
      @application = Application.new
    end
  end

  def new
    @customer = current_customer
    @request = Request.new
  end

  def create
    @request = current_customer.requests.new(request_params)
    if @request.save
      redirect_to request_path(@request), notice: '登録しました'
    else
      flash[:alert] = '愛犬情報は必ず入力してください'
      @customer = current_customer
      redirect_to new_request_path(@request)
    end
  end

  def destroy
    requesta = Request.find(params[:id])
    requesta.destroy
    redirect_to customers_mypage_path, notice: '依頼を削除しました'
  end


  private
  def request_params
    params.require(:request).permit(:comment, :dog_id, :prefecture_code, :first_preferred_date, :last_preferred_date)
  end
end