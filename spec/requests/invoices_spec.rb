require 'rails_helper'

RSpec.describe "Invoices API", type: :request do
  describe "GET /invoices/overdue" do
    let!(:overdue_invoice) { create(:invoice, due_date: 5.days.ago, status: :init) }
    let!(:paid_invoice)    { create(:invoice, due_date: 10.days.ago, status: :paid) }

    it "returns only overdue unpaid invoices" do
      get "/invoices/overdue"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["invoices"]).to be_an(Array)
      expect(json["invoices"].map { |i| i["id"] }).to include(overdue_invoice.id)
      expect(json["invoices"].map { |i| i["id"] }).not_to include(paid_invoice.id)

      expect(json["total_count"]).to eq(1)
      expect(json["total_amount"]).to eq(overdue_invoice.invoice_amount)
    end
  end

  describe "POST /invoices/generate" do
    let(:generator) { instance_double(Demurrage::InvoiceGenerator) }

    before do
      allow(Demurrage::InvoiceGenerator).to receive(:new).and_return(generator)
    end

    context "when generation succeeds" do
      before do
        allow(generator).to receive(:run).and_return(true)
        allow(generator).to receive(:summary).and_return({ generated_count: 2, total_amount: 1000 })
      end

      it "returns 201 with success message" do
        post "/invoices/generate"

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)

        expect(json["success"]).to be true
        expect(json["message"]).to eq("Invoice(s) generated")
        expect(json["summary"]).to eq({ "generated_count" => 2, "total_amount" => 1000 })
      end
    end

    context "when generation fails" do
      before do
        allow(generator).to receive(:run).and_return(false)
        allow(generator).to receive(:summary).and_return({ generated_count: 0, total_amount: 0 })
      end

      it "returns 422 with error message" do
        post "/invoices/generate"

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)

        expect(json["success"]).to be false
        expect(json["message"]).to eq("Invoice generation completed with errors")
      end
    end
  end
end
