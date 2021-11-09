class Customer::RequestsController < ApplicationController
  def show
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
      flash[:alert] = '登録に失敗しました'
      render :new
    end
  end


  private
  def request_params
    params.require(:request).permit(:comment, :dog_id, :prefecture_code)
  end
end
