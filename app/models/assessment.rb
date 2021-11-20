class Assessment < ApplicationRecord
  belongs_to :like, class_name: "Customer"
  belongs_to :get_like, class_name: "Customer"
end
