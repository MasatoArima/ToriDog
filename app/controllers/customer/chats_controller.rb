class Customer::ChatsController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = Customer.find(params[:id])
    rooms = current_customer.entries.pluck(:room_id)
    entries = Entry.find_by(customer_id: @customer.id, room_id: rooms)

    if entries.nil?
      @room = Room.new
      @room.save
      Entry.create(customer_id: current_customer.id, room_id: @room.id)
      Entry.create(customer_id: @customer.id, room_id: @room.id)
    else
      @room = entries.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    chat = current_customer.chats.new(chat_params)
    chat.save
    room = Room.find(chat.room_id)
    @chats = room.chats
    @chat = Chat.new(room_id: room.id)
  end

  def destroy
    chat = Chat.find(params[:id])
    chat.destroy
    room = Room.find(chat.room_id)
    @chats = room.chats
    @chat = Chat.new(room_id: room.id)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
