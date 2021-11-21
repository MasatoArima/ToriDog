FactoryBot.define do
  factory :dog do
    customer_id { 1 }
    name {"犬"}
    name_kana {"イヌ"}
    breed {"レトリバー"}
    sex {"true"}
    size { 1 }
    is_inoculate {"true"}
    inoculation_date {"00000000"}
    birthday {"00000000"}
  end
end