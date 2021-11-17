class Customer::ContractsController < ApplicationController
  def show
    @contract = Contract.find(params[:id])
    @customers = Customer.all
    @messages = Message.where(contract_id: (params[:id]))
    @application = Application.find(@contract.application_id)
    @request = Request.find(@application.request_id)
    @dog = Dog.find(@request.dog_id )
    @dog_owner = Customer.find(@request.customer_id)
    @trimmer = Customer.find(@application.customer_id)
    ##
    if @contract.evaluation.nil?
      @evaluation = Evaluation.new
    else
      @evaluation = @contract.evaluation
    end
    ##
  end

  def new
    @application = Application.find(params[:id])
    @dog = Dog.find(@application.request.dog_id )
    @customer = current_customer
    @trimmer = Customer.find(@application.customer_id )
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    application = Application.find(params[:id])
    if @contract.save && application.update(contract_id: @contract.id)
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
      redirect_to request.referer, notice: '更新しました'
    elsif @contract.is_status == "in_progress"
      if params[:status] == "complete"
        requesta = Request.find(@contract.application.request_id)
        requesta.update(is_complete: true)
        redirect_to contracts_complete_path(id: @contract.id)
      else
        redirect_to contract_path(@contract.id), notice: '更新しました'
      end
    elsif @contract.is_status == "cancel"
      redirect_to customers_mypage_path
    elsif @contract.is_status == "completion"
      evaluation = Evaluation.new(evaluation_params[:evaluation])
      evaluation.save
      evaluation.update(rate_params)
      redirect_to customers_mypage_path
    end
  end

  def complete
    @contract = Contract.find(params[:id])
  end

  def destroy
    contract = Contract.find(params[:id])
    application = Application.find(contract.application_id)
    contract.destroy && application.destroy
    redirect_to customers_mypage_path
  end

  private
  def contract_params
    params.require(:contract).permit(:application_id, :is_status, :dog_owner_is_consent, :trimmer_is_consent, :preferred_date, :client_id, :trimmer_id)
  end

  def evaluation_params
    params.require(:contract).permit(evaluation:[:comment, :contract_id])
  end

  def rate_params
    params.require(:evaluation).permit(:rate)
  end

end