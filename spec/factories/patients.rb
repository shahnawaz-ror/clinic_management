FactoryBot.define do
  factory :patient do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    dob { Faker::Date.birthday(min_age: 0, max_age: 100) }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }

    association :user  # Assuming this is required
  end
end
