class Customer::AssessmentsController < ApplicationController
  def create
    current_customer.likes(params[:customer_id])
    redirect_to request.referer
  end

  def destroy
    current_customer.unlikes(params[:customer_id])
    redirect_to request.referer
  end

  def likings
    customer = Customer.find(params[:customer_id])
    @customers = customer.likings
  end

  def likers
    customer = Customer.find(params[:customer_id])
    @customers = customer.likers
  end
end
