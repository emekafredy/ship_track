FactoryBot.define do
  factory :bill_of_lading do
    association :customer

    freetime { 7 }
    number { "BL-#{Faker::Alphanumeric.alphanumeric(number: 6).upcase}" }
    upload_date { Time.current }
    vessel_name do
       suffix = [ Faker::Address.city, Faker::Creature::Animal.name, Faker::Color.color_name.capitalize ].sample
      "Vessel #{suffix}"
    end
    consignee_name { Faker::Name.name }

    trait :bl1 do
      freetime { 7 }
      arrival_date { 7.days.ago }
      nbre_40pieds_sec { 1 }
      nbre_20pieds_sec { 2 }
    end

    trait :bl2 do
      freetime { 10 }
      arrival_date { 11.days.ago }
      nbre_40pieds_sec { 2 }
      nbre_20pieds_sec { 1 }
      nbre_20pieds_frigo { 2 }
    end

    trait :bl3 do
      freetime { 5 }
      arrival_date { 3.days.ago }
      nbre_40pieds_sec { 5 }
      nbre_20pieds_sec { 4 }
    end

    trait :bl4 do
      freetime { 6 }
      arrival_date { 7.days.ago }
      nbre_40pieds_sec { 10 }
      nbre_20pieds_sec { 4 }
      nbre_20pieds_frigo { 6 }
    end
  end
end
