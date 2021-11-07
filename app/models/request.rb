class Request < ApplicationRecord
  belongs_to :customer
  has_many :applications
end
