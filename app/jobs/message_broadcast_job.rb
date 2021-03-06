class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "contract_channel_#{message.contract_id}", message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render partial: 'customer/messages/message', locals: { message: message }
  end
end
