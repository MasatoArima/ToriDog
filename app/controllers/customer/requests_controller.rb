class Customer::RequestsController < ApplicationController
  def new
    @customer = current_customer
  end

end
