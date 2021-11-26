class Admin::ContractsController < ApplicationController
  before_action :setup

  def index
  end

  def show
    @contract = Contract.find(params[:id])
    @application = Application.find_by(id: @contract.application_id)
    @dog = Dog.find_by(id: @application.request.dog_id)
    @dog_owner = @customers.find(@requests.find(@applications.find(@contract.application_id).request_id).customer_id)
    @trimmer = @customers.find(@applications.find(@contract.application_id).customer_id)
  end

  private

  def setup
    @contracts = Contract.all.order(id: :DESC)
    @applications = Application.all
    @requests = Request.all
    @customers = Customer.all
  end
end
