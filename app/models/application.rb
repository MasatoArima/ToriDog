class Application < ApplicationRecord
  belongs_to :customer
  belongs_to :request
  # belongs_to :contract
end
