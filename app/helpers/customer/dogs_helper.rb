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
      "済" "(#{data.inoculation_day})"
    else
      "未"
    end
  end
end
