module Customer::RoomsHelper
  def notification?(data)
    rooms = current_customer.entries.pluck(:room_id)
    entries = Entry.find_by(customer_id: data.id, room_id: rooms)
    room = entries.room
    chatsa = room.chats.where.not(customer_id: current_customer.id)
    tmp = false
    chatsa.each do |c|
      if c.notification == false
        tmp = true
      end
    end

    if tmp == true
      "有"
    else
      "無"
    end
  end
end
