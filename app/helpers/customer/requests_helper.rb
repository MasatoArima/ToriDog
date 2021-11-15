module Customer::RequestsHelper
  def contract_inprogress(data)
    if @contracts.find_by(application_id: @applications.find_by(request_id: data.id))
      true
    else
      false
    end
  end
end
