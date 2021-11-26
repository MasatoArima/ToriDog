module Customer::ContractsHelper
  def trimming_finish(data)
    data.preferred_date < Time.now
  end
end
