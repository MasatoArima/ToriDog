FactoryBot.define do
  factory :request do
    customer_id { 1 }
    dog_id { 1 }
    comment {"テスト"}
    prefecture_code {"福島"}
  end
end
