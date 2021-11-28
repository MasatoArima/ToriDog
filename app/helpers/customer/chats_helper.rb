module Customer::ChatsHelper
  def read?(data)
    if data.notification == false
      "未読"
    else
      "既読"
    end
  end
end
