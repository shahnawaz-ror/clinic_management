FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    role { 'receptionist' }  # Set the role of the user here, or make it dynamic
  end
end
