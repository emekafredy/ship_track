class BillOfLading < ApplicationRecord
  belongs_to :customer
  has_many :invoices, foreign_key: :bill_of_lading_number, primary_key: :number, dependent: :destroy
end
