class Application < ApplicationRecord
  belongs_to :customer
  belongs_to :request
end
