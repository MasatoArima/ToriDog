class Request < ApplicationRecord
  belongs_to :customer
  belongs_to :dog
  has_many :applications, dependent: :destroy
end
