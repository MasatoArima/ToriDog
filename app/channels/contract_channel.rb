class ContractChannel < ApplicationCable::Channel
  # 接続されたとき
  def subscribed
    # stream_from "some_channel"
    stream_from "contract_channel_#{params['contract']}"
  end

  # 切断されたとき
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(content: data['message'], customer_id: current_customer.id, contract_id: params['contract'], sender: params['sender'])
    ActionCable.server.broadcast "contract_channel_#{params['contract']}", message: message
  end
end
