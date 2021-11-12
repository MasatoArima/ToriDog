module Customer::DogsHelper
  def sex(data)
    if data.sex == true
      "オス"
    else
      "メス"
    end
  end

  def is_inoculate(data)
    if data.is_inoculate == true
      "接種済" "(#{data.inoculation_date})"
    else
      "未接種"
    end
  end

end
