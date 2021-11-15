class Contract < ApplicationRecord

  validates :preferred_date, presence: true

  # 1対1の記述ー－－－－－－
  # has_one :application
  # ー－－－－－－－－－－－
  #enum使用
  enum is_status: { in_preparation: 0, in_progress: 1, completion: 2, cancel: 3}
end
