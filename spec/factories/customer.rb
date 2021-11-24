FactoryBot.define do
  factory :customer, aliases: [:dog_owner] do
    email { "dog_owner@test.com" }
    password { "111111" }
    password_confirmation { "111111" }
    last_name { "飼い主" }
    first_name { "test1" }
    last_name_kana { "カイヌシ" }
    first_name_kana { "テスト" }
    post_code { "9620403" }
    prefecture_code { "福島県" }
    city { "須賀川市" }
    street { "滑川" }
    phone_number { "08000000000" }
    user_status { 0 }
    is_deleted { "false" }
  end

  factory :trimmer, :class => "Customer" do
    email { "trimmer@test.com" }
    password { "111111" }
    password_confirmation { "111111" }
    last_name { "トリマ" }
    first_name { "test1" }
    last_name_kana { "トリマ" }
    first_name_kana { "テスト" }
    post_code { "9620403" }
    prefecture_code { "福島県" }
    city { "須賀川市" }
    street { "滑川" }
    phone_number { "08000000000" }
    user_status { 1 }
    is_deleted { "false" }
  end
end
