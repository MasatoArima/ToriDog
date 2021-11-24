module Customer::RequestsHelper
  def contracts_inprogress(data)
    contracts = current_customer.client_contract
    applications = Application.all
    tmp = "false"
    applications.each do |application|
      if contracts.find_by(application_id: application.id)
        tmp = "true"
      end
    end
    if tmp == "true"
      "true"
    else
      "false"
    end
  end
end
