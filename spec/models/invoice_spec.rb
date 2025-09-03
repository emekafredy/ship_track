require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "associations" do
    it { should belong_to(:bill_of_lading).with_foreign_key(:bill_of_lading_number).with_primary_key(:number) }
  end

  describe "validations" do
    it { should validate_presence_of(:due_date) }
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:invoice_date) }
    it { should validate_presence_of(:customer_code) }
    it { should validate_length_of(:customer_code).is_at_most(20) }
    it { should validate_presence_of(:customer_name) }
    it { should validate_length_of(:customer_name).is_at_most(60) }
    it { should validate_presence_of(:bill_of_lading_number) }
    it { should validate_length_of(:bill_of_lading_number).is_equal_to(9) }
    it { should validate_presence_of(:invoice_amount) }
    it { should validate_numericality_of(:invoice_amount).is_greater_than(0) }
    it { should validate_presence_of(:reference) }
    it { should validate_length_of(:reference).is_at_most(10) }
    it { should validate_presence_of(:status) }
  end

  describe "scopes" do
    describe ".overdue" do
      let!(:overdue_invoice) { create(:invoice, due_date: 3.days.ago, status: :init) }
      let!(:paid_invoice)    { create(:invoice, due_date: 5.days.ago, status: :paid) }
      let!(:future_invoice)  { create(:invoice, due_date: 3.days.from_now, status: :init) }

      it "returns only overdue and unpaid invoices" do
        expect(Invoice.overdue).to include(overdue_invoice)
        expect(Invoice.overdue).not_to include(paid_invoice)
        expect(Invoice.overdue).not_to include(future_invoice)
      end
    end
  end
end
