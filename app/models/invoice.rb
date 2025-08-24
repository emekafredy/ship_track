class Invoice < ApplicationRecord
  belongs_to :bill_of_lading, foreign_key: :bill_of_lading_number, primary_key: :number

  enum :status, { init: "init", sent: "sent", paid: "paid" }.freeze

  scope :overdue, -> { where("due_date < ? AND status != ?", Date.current, "paid") }
  scope :unpaid, -> { where.not(status: "paid") }
  scope :paid, -> { where(status: "paid") }
end
