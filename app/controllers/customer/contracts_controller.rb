class Customer::ContractsController < ApplicationController
  def show
    @contract = Contract.find(params[:id])
    @application = Application.find(@contract.application_id)
    @request = Request.find(@application.request_id)
    @dog = Dog.find(@request.dog_id )
    @dog_owner = Customer.find(@request.customer_id)
    @trimmer = Customer.find(@application.customer_id)
  end

  def new
    @application = Application.find(params[:id])
    @dog = Dog.find_by(id: @application.request.dog_id )
    @customer = current_customer
    @torimmer = Customer.find_by(id: @application.request.customer_id )
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to contract_path(@contract), notice: '登録しました'
    else
      flash[:alert] = '登録に失敗しました'
      render :new
    end
  end
  def update
    @contract = Contract.find(params[:id])
    @contract.update(contract_params)
    if @contract.is_status == "in_preparation"
      redirect_to request.referer
    elsif @contract.is_status == "in_progress"
      requests = Request.all
      applications = Application.all
      request = requests.find(applications.find(@contract.application_id).request_id)
      request.update(is_complete: true)
      redirect_to contracts_complete_path(id: @contract.id)
    end
  end

  def complete
    @contract = Contract.find(params[:id])
  end

  def check
  end

  private
  def contract_params
    params.require(:contract).permit(:application_id, :is_status,:dog_owner_is_consent,:trimmer_is_consent)
  end
end