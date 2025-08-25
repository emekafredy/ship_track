# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

customers = []
customers << Customer.create!(
  name: "AA Trading Co",
  group_name: "AA Group",
  customer_code: "AAT001",
)
customers << Customer.create!(
  customer_code: "GLB002",
  group_name: "Global Group",
  name: "Global Imports Ltd",
)
customers << Customer.create!(
  customer_code: "WAL003",
  group_name: "WAL Group",
  name: "West Africa Logistics"
)

bill_of_ladings = []
bill_of_ladings << BillOfLading.create!(
  freetime: 7,
  statut: "arrived",
  nbre_40pieds_sec: 1,
  nbre_20pieds_sec: 2,
  number: "AA00001",
  customer: customers[0],
  vessel_name: "MSC GEN",
  arrival_date: 7.days.ago,
  consignee_name: "AA Trading Co",
)
bill_of_ladings << BillOfLading.create!(
  freetime: 10,
  statut: "arrived",
  number: "GLB000002",
  nbre_20pieds_sec: 1,
  nbre_40pieds_sec: 2,
  nbre_20pieds_frigo: 1,
  customer: customers[1],
  arrival_date: 11.days.ago,
  vessel_name: "VOLTA",
  consignee_name: "Global Imports Ltd",
)
bill_of_ladings << BillOfLading.create!(
  freetime: 5,
  statut: "arrived",
  nbre_40pieds_sec: 3,
  number: "WAL000003",
  vessel_name: "MAERSK",
  customer: customers[2],
  arrival_date: 3.days.ago,
  consignee_name: "West Africa Logistics",
)
bill_of_ladings << BillOfLading.create!(
  freetime: 5,
  statut: "arrived",
  nbre_40pieds_sec: 3,
  number: "GLB000005",
  vessel_name: "VOLTAB",
  customer: customers[1],
  arrival_date: 60.days.ago,
  consignee_name: "Global Imports Ltd",
)


Invoice.create!(
  status: "sent",
  currency: "USD",
  invoice_amount: 240,
  reference: "INV0001",
  due_date: 5.days.ago,
  invoice_date: 20.days.ago,
  customer_id: customers[2].id,
  customer_name: customers[2].name,
  customer_code: customers[2].customer_code,
  bill_of_lading_number: bill_of_ladings[2].number,
)
Invoice.create!(
  status: "paid",
  currency: "USD",
  invoice_amount: 160,
  reference: "INV0002",
  due_date: 15.days.ago,
  invoice_date: 30.days.ago,
  customer_id: customers[1].id,
  customer_name: customers[1].name,
  customer_code: customers[1].customer_code,
  bill_of_lading_number:  bill_of_ladings[3].number,
)

puts "#{Customer.count} customers seeded"
puts "#{BillOfLading.count} bills of lading seeded"
puts "#{Invoice.count} invoices seeded"
