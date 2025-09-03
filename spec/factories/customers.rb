FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    customer_code { Faker::Alphanumeric.alphanumeric(number: 6).upcase }
    group_name { Faker::Company.name }
  end
end
