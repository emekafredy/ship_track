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


c1 = FactoryBot.create(:customer)
c2 = FactoryBot.create(:customer)
c3 = FactoryBot.create(:customer)

c1bl1 = FactoryBot.create(:bill_of_lading, :bl1, customer: c1)
FactoryBot.create(:bill_of_lading, :bl2, customer: c1)
c1bl3 = FactoryBot.create(:bill_of_lading, :bl3, customer: c1)
FactoryBot.create(:bill_of_lading, :bl3, customer: c1)

c2bl1 = FactoryBot.create(:bill_of_lading, :bl1, customer: c2)
c3bl2 = FactoryBot.create(:bill_of_lading, :bl2, customer: c2)
c2bl3 = FactoryBot.create(:bill_of_lading, :bl3, customer: c2)
FactoryBot.create(:bill_of_lading, :bl4, customer: c2)

c3bl1 = FactoryBot.create(:bill_of_lading, :bl1, customer: c3)
c3bl2 = FactoryBot.create(:bill_of_lading, :bl2, customer: c3)
c3bl3 = FactoryBot.create(:bill_of_lading, :bl3, customer: c3)
c3bl4 = FactoryBot.create(:bill_of_lading, :bl4, customer: c3)

FactoryBot.create(:invoice, bill_of_lading: c1bl1, status: 'sent', due_date: 2.days.ago)
FactoryBot.create(:invoice, bill_of_lading: c1bl3, status: 'sent', due_date: 5.days.ago)
FactoryBot.create(:invoice, bill_of_lading: c2bl1, status: 'sent', due_date: 6.days.ago)
FactoryBot.create(:invoice, bill_of_lading: c3bl2, status: 'init', due_date: 2.days.from_now)
FactoryBot.create(:invoice, bill_of_lading: c2bl3, status: 'paid', due_date: 3.days.ago)
FactoryBot.create(:invoice, bill_of_lading: c3bl1, status: 'sent', due_date: 4.days.ago)
FactoryBot.create(:invoice, bill_of_lading: c3bl3, status: 'paid', due_date: 2.days.ago)
FactoryBot.create(:invoice, bill_of_lading: c3bl4, status: 'paid', due_date: 2.months.ago)

puts "Records Created"
