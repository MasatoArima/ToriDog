module Customer::CustomersHelper
  def is_trimmer?
    current_customer.user_status == "trimmer"
  end
end
