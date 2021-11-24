FactoryBot.define do
  factory :application, class: Application do
    customer_id { 2 }
    request_id { 1 }
    contract_id { 1 }
    comment {"テストです"}
  end
  factory :application1, class: Application do
    customer_id { 2 }
    request_id { 1 }
    contract_id { 1 }
    comment {"テストです"}
  end
  factory :application2, class: Application do
    customer_id { 2 }
    request_id { 1 }
    contract_id { 1 }
    comment {"テストです"}
    first_preferred_date {"002020-10-06"}
  end
  factory :application3, class: Application do
    customer_id { 2 }
    request_id { 1 }
    contract_id { 1 }
    comment {"テストです"}
    first_preferred_date {"002020-10-06"}
    last_preferred_date {"002020-10-07"}
  end
end