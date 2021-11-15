class Customer::ContractsController < ApplicationController
  def show
    @customers = Customer.all
    @messages = Message.where(contract_id: (params[:id]))
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
      flash[:alert] = '施術希望日は必ず入力してください'
      redirect_to request.referer
    end
  end
  def update
    @contract = Contract.find(params[:id])
    @contract.update(contract_params)
    if @contract.is_status == "in_preparation"
      redirect_to request.referer
    elsif @contract.is_status == "in_progress"
      if (@contract.dog_owner_is_consent == "true") && (@contract.trimmer_is_consent == "true")
        requests = Request.all
        applications = Application.all
        request = requests.find(applications.find(@contract.application_id).request_id)
        request.update(is_complete: true)
        redirect_to contracts_complete_path(id: @contract.id)
      else
        redirect_to request.referer
      end
    elsif @contract.is_status == "cancel"
      redirect_to customers_mypage_path
    elsif @contract.is_status == "completion"
      redirect_to customers_mypage_path
    end
  end

  def complete
    @contract = Contract.find(params[:id])
  end

  def check
  end

  def destroy
    contract = Contract.find(params[:id])
    contract.destroy
    redirect_to customers_mypage_path
  end

  private
  def contract_params
    params.require(:contract).permit(:application_id, :is_status,:dog_owner_is_consent,:trimmer_is_consent, :preferred_date)
  end
end