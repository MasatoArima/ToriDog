class Customer::RoomsController < ApplicationController
  before_action :authenticate_customer!
end
