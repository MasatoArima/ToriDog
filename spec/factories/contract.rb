FactoryBot.define do
  factory :contract do
    application_id { 1 }
    is_status { 0 }
    dog_owner_is_consent {"false"}
    trimmer_is_consent {"false"}
  end
end
