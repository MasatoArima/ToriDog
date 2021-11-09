class Application < ApplicationRecord
  belongs_to :customer
  belongs_to :request

  # 1対1の記述ー－－－－－－
  # belongs_to :contract
  # ー－－－－－－－－－－－
end
