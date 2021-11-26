FactoryBot.define do
  factory :contract do
    application_id { 1 }
    evaluation_id { 1 }
    is_status { 0 }
    dog_owner_is_consent { "false" }
    trimmer_is_consent { "false" }
    preferred_date { "002020-10-07" }
    client_id { 1 }
    trimmer_id { 2 }
  end
end
