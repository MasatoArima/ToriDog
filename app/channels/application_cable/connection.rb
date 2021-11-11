module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_customer

    def connect
      self.current_customer = find_verified_customer
    end

    protected
    def find_verified_customer
        if verified_customer = Customer.find_by(id: cookies.signed['customer_id'])
          verified_customer
        else
          reject_unauthorized_connection
        end
    end
  end
end