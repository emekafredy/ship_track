FactoryBot.define do
  factory :invoice do
    sequence(:reference) { |n| "INV#{n.to_s.rjust(6, '0')}" }
    association :bill_of_lading

    bill_of_lading_number { bill_of_lading.number }
    customer_code { bill_of_lading.customer.customer_code }
    customer_name { bill_of_lading.customer.name }
    invoice_amount { rand(1_000..50_000) }
    original_amount { invoice_amount.to_f * 1.1 }
    invoice_date { Time.current }
    customer_id { rand(1..10) }
  end
end
