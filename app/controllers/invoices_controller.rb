class InvoicesController < ApplicationController
  def overdue
    overdue_invoices = Invoice.includes(:bill_of_lading).overdue

    render json: {
      invoices: overdue_invoices.map do |invoice|
        {
          id: invoice.id,
          status: invoice.status,
          currency: invoice.currency,
          due_date: invoice.due_date,
          reference: invoice.reference,
          amount: invoice.invoice_amount,
          invoice_date: invoice.invoice_date,
          customer_name: invoice.customer_name,
          bill_of_lading_number: invoice.bill_of_lading_number
        }
      end,
      total_count: overdue_invoices.count,
      total_amount: overdue_invoices.sum(:invoice_amount)
    }, status: 200
  end

  def generate
    generator = Demurrage::InvoiceGenerator.new

    if generator.run
      render json: { success: true, summary: generator.summary, message: "Invoice(s) generated" }, status: 201
    else
      render json: { success: false, summary: generator.summary, message: "Invoice generation completed with errors" }, status: 422
    end
  end
end
