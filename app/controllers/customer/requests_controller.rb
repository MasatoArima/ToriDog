class Customer::RequestsController < ApplicationController
  def show
    @request = Request.find(params[:id])
    @customer = Customer.find_by(id: @request.customer_id)
    @dog = Dog.find_by(id: @request.dog_id)
    @applications = @request.applications
    @contracts = Contract.all
    @application = @applications.find_by(customer_id: current_customer.id)
    if @application.nil?
      @application = Application.new
    end
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_customer.requests.new(request_params)
    if @request.save
      redirect_to request_path(@request), notice: '登録しました'
    else
      flash[:alert] = '愛犬情報は必ず入力してください'
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