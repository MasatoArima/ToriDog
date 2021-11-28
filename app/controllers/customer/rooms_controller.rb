class Customer::RoomsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    rooms = current_customer.entries.pluck(:room_id)
    @entries = Entry.where(room_id: rooms).where.not(customer_id: @customer.id)
    tmp = []
    @entries.each do |e|
      tmp.push(e.customer_id)
    end
    @user = Customer.where(id: tmp)
  end
end
