class Contract < ApplicationRecord

  validates :preferred_date, presence: true
  belongs_to :client, class_name: "Customer"
  belongs_to :trimmer, class_name: "Customer"

  # 1対1の記述ー－－－－－－
  has_one :application
  # ー－－－－－－－－－－－
  #enum使用
  enum is_status: { in_preparation: 0, in_progress: 1, completion: 2, cancel: 3}
end
