module Customer::CustomersHelper
  def is_trimmer?
    current_customer.user_status == "trimmer"
  end

 #依頼関連
  def is_cutomer_request(data)
    if (current_customer.id == @requests.find(data.id).customer_id) && (data.is_complete == false)
      true
    else
      false
    end
  end

  def request_dog_name(data)
     @dogs.find(data.dog_id).name
  end

  def request_dog_owner_name(data)
     @customers.find(data.customer_id).full_name
  end
  def application_count(data)
     @applications.where(request_id: data.id).count
  end
  def contract_count(data)
    applications = @applications.where(customer_id: data.id)
    contract_count = 0
    applications.each do |application|
      unless @contracts.where(application_id: application.id).blank?
        contract = @contracts.find_by(application_id: application.id)
        if contract.is_status == "completion"
          contract_count += 1
        end
      else
      end
    end
    return contract_count
  end

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
    @dog_owners.find(@requests.find(@applications.find(data.application_id).request_id).customer_id).full_name
  end

  def contract_trimmer_name(data)
    link_to customer_path(@trimmers.find(@applications.find(data.application_id).customer_id).id) do
      @trimmers.find(@applications.find(data.application_id).customer_id).full_name
    end
  end

  def is_customer(data)
    if current_customer.id ==  @requests.find(@applications.find(data.application_id).request_id).customer_id
      true
    else
      false
    end
  end

end
