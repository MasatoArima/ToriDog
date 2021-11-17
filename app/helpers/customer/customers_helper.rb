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


  def consent_status(data)
    if data.is_status == "in_preparation"
      if is_trimmer?
        if (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == false)
          "(契約待機中)"
        elsif (data.trimmer_is_consent == false) && (data.dog_owner_is_consent == true)
          "(飼い主は契約に同意しています)"
        elsif (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == true)
          "(契約確定中)"
        else
          "(契約内容を確認してください)"
        end
      else
        if (data.trimmer_is_consent == false) && (data.dog_owner_is_consent == true)
          "(契約待機中)"
        elsif (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == false)
          "(トリマーは同意しています)"
        elsif (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == true)
          "(契約を確定できます)"
        else
          "(契約内容を確認してください)"
        end
      end
    elsif data.is_status == "in_progress"
      if is_trimmer?
        if (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == false)
          "(中止依頼中)"
        elsif (data.trimmer_is_consent == false) && (data.dog_owner_is_consent == true)
          "(中止依頼があります)"
        elsif (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == true)
          "(中止確定中)"
        else
        end
      else
        if (data.trimmer_is_consent == false) && (data.dog_owner_is_consent == true)
          "(中止依頼中)"
        elsif (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == false)
          "(中止依頼があります)"
        elsif (data.trimmer_is_consent == true) && (data.dog_owner_is_consent == true)
          "(契約を中止できます)"
        else
        end
      end
    end
  end

  def evaluation_ave(data)
    contracts = data.trimmer_contract
    rate_average = 0
    count = 0
    unless contracts.blank?
      contracts.each do |contract|
        if contract.evaluation.nil?
        else
          rate_average += (contract.evaluation.rate).to_i
          count += 1
        end
      end
      return rate_average / count
    else
      0
    end
  end

end
