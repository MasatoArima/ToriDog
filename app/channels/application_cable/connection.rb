module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_customer

    def connect
      self.current_customer = find_verified_customer
    end

    # rubocop:disable all
    protected

    def find_verified_customer
      if verified_customer = Customer.find_by(id: cookies.signed['customer_id'])
        verified_customer
      else
        reject_unauthorized_connection
      end
    end
    # rubocop:enable all
  end
end
