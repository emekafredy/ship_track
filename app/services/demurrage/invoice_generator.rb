# frozen_string_literal: true

module Demurrage
  class InvoiceGenerator
    attr_reader :created_invoices, :skipped_bls, :errors

    def initialize
      @created_invoices = []
      @skipped_bls = []
      @errors = []
    end

    def run
      ActiveRecord::Base.transaction do
        todays_overdue_bls.find_each do |bl|
          process_bill_of_lading(bl)
        end
      end

      success?
    end

    def summary
      {
        errors: errors,
        created_invoices_count: created_invoices.count,
        created_invoices: created_invoices.map(&:as_json),
        skipped_bls: skipped_bls.map { |bl| { number: bl.number, reason: bl[:skip_reason] } }
      }
    end


    private

    def success?
      errors.empty?
    end

    def todays_overdue_bls
      BillOfLading.joins(:customer).overdue_today
    end

    def process_bill_of_lading(bl)
      if bl.has_open_invoice?
        skip_bl(bl, "Has an open invoice")
        return
      end

      create_invoice_for_bl(bl)
    rescue StandardError => e
      errors << "Error processing Bill of Lading #{bl.number}: #{e.message}"
      Rails.logger.error "InvoiceGenerator error for Bill of Lading #{bl.number}: #{e.message}"
    end

    def create_invoice_for_bl(bl)
      invoice = Invoice.new(
        invoice_date: Time.current,
        customer_id: bl.customer.id,
        customer_name: bl.customer.name,
        bill_of_lading_number: bl.number,
        due_date: Date.current + 15.days,
        invoice_amount: bl.calculate_demurrage_amount,
        reference: Utility::RandomString.alphanumeric,
        customer_code: bl.customer.customer_code || "UNKNOWN",
      )

      if invoice.save
        @created_invoices << invoice
        Rails.logger.info "Created invoice #{invoice.reference} for Bill of Lading #{bl.number}"
      else
        errors << "Failed to create invoice for Bill of Lading #{bl.number}: #{invoice.errors.full_messages.join(', ')}"
      end
    end

    def skip_bl(bl, reason)
      skipped_bls << bl.tap { |b| b.define_singleton_method(:skip_reason) { reason } }
      Rails.logger.info "Skipped Bill of Lading #{bl.number}: #{reason}"
    end
  end
end
