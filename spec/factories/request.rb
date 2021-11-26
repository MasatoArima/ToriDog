FactoryBot.define do
  factory :request, :class => "Request" do
    customer_id { 1 }
    dog_id { 1 }
    comment { "テスト" }
    prefecture_code { "福島" }
  end
  factory :request1, :class => "Request" do
    customer_id { 1 }
    dog_id { 1 }
    comment { "テスト" }
    prefecture_code { "福島" }
  end
  factory :request2, :class => "Request" do
    customer_id { 1 }
    dog_id { 1 }
    comment { "テスト" }
    prefecture_code { "福島" }
    first_preferred_date { "002020-10-06" }
  end
  factory :request3, :class => "Request" do
    customer_id { 1 }
    dog_id { 1 }
    comment { "テスト" }
    prefecture_code { "福島" }
    first_preferred_date { "002020-10-06" }
    last_preferred_date { "002020-10-07" }
  end
end
