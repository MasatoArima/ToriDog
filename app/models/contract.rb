class Contract < ApplicationRecord
  # has_one :application

  #enum使用
  enum is_status: { in_preparation: 0, in_progress: 1, completion: 2, cancel: 3}
end
