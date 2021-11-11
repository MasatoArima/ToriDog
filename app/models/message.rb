class Message < ApplicationRecord
  belongs_to :customer
  after_create_commit { MessageBroadcastJob.perform_later self }
end
