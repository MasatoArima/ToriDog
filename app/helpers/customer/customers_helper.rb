module Customer::CustomersHelper
  def is_trimmer?
    current_customer.user_status == "trimmer"
  end

 #依頼関連
  def request_dog_name(data)
     @dogs.find(data.dog_id).name
  end

  def request_dog_owner_name(data)
     @customers.find(data.customer_id).full_name
  end
  # def application_count(data)
  #   data.applications.count
  # end

  def request_status(data)
    if @applications.find_by(customer_id: current_customer.id, request_id: data.id)
      "済"
    else
      "未"
    end
  end


 #契約関連
  def contract_dog_name(data)
    @dogs.find(@requests.find(@applications.find(data.application_id).request_id).dog_id).name
  end

  def contract_dog_owner_name(data)
    @customers.find(@requests.find(@applications.find(data.application_id).request_id).customer_id).full_name
  end

  def contract_trimmer_name(data)
    link_to customer_path(data.trimmer_id) do
      @customers.find(data.trimmer_id).full_name
    end
  end

end
