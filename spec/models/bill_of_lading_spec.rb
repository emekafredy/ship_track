require 'rails_helper'

RSpec.describe BillOfLading, type: :model do
  describe "associations" do
    it { should belong_to(:customer) }
    it { should have_many(:invoices).with_foreign_key(:bill_of_lading_number).with_primary_key(:number) }
  end

  describe "validations" do
    it { should validate_presence_of(:arrival_date) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:freetime) }
    it { should validate_numericality_of(:freetime).is_greater_than(0) }
  end

  describe "scopes" do
    describe ".overdue_today" do
      let!(:bl_due_today) { create(:bill_of_lading, freetime: 7, arrival_date: 7.days.ago) }
      let!(:bl_not_due)   { create(:bill_of_lading, freetime: 5, arrival_date: 1.day.ago) }

      it "returns B/L records that are overdue today" do
        expect(BillOfLading.overdue_today).to include(bl_due_today)
        expect(BillOfLading.overdue_today).not_to include(bl_not_due)
      end
    end
  end

  describe "#total_containers" do
    it "sums up all container counts" do
      bl = build(:bill_of_lading, nbre_20pieds_sec: 2, nbre_40pieds_sec: 1, nbre_20pieds_frigo: 3)
      expect(bl.total_containers).to eq(6)
    end
  end

  describe "#has_open_invoice?" do
    let(:bl) { create(:bill_of_lading) }

    it "returns true if unpaid invoice exists" do
      create(:invoice, bill_of_lading: bl, bill_of_lading_number: bl.number, status: :init, due_date: 4.days.ago)
      expect(bl.has_open_invoice?).to be true
    end

    it "returns false if all invoices are paid" do
      create(:invoice, bill_of_lading: bl, bill_of_lading_number: bl.number, status: :paid, due_date: 3.day.ago)
      expect(bl.has_open_invoice?).to be false
    end
  end

  describe "#calculate_demurrage_amount" do
    it "calculates based on total containers * 80" do
      bl = build(:bill_of_lading, nbre_20pieds_sec: 2, nbre_40pieds_sec: 1)
      expect(bl.calculate_demurrage_amount).to eq(3 * 80)
    end
  end
end
