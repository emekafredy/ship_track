class Invoice < ApplicationRecord
  belongs_to :bill_of_lading, foreign_key: :bill_of_lading_number, primary_key: :number

  validates :due_date, presence: true
  validates :customer_id, presence: true
  validates :invoice_date, presence: true
  validates :customer_code, presence: true, length: { maximum: 20 }
  validates :customer_name, presence: true, length: { maximum: 60 }
  validates :bill_of_lading_number, presence: true, length: { is: 9 }
  validates :invoice_amount, presence: true, numericality: { greater_than: 0 }
  validates :reference, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :status, presence: true, inclusion: { in: %w[init sent overdue paid cancelled] }

  enum :status, { init: "init", sent: "sent", paid: "paid", overdue: "overdue", cancelled: "cancelled" }.freeze

  scope :overdue, -> { where("due_date < ? AND status != ?", Date.current, "paid") }
  scope :unpaid, -> { where.not(status: "paid") }
  scope :paid, -> { where(status: "paid") }
end
