require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "associations" do
    it { should have_many(:bill_of_ladings) }
    it { should have_many(:invoices).through(:bill_of_ladings) }
  end

  describe "validations" do
    it { should validate_length_of(:customer_code).is_at_most(20) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(60) }
    it { should validate_presence_of(:group_name) }
    it { should validate_length_of(:group_name).is_at_most(150) }
  end
end
