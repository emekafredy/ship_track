class BillOfLading < ApplicationRecord
  belongs_to :customer
  has_many :invoices, foreign_key: :bill_of_lading_number, primary_key: :number

  validates :arrival_date, presence: true
  validates :number, presence: true, uniqueness: true
  validates :freetime, presence: true, numericality: { greater_than: 0 }

  scope :overdue_today, -> { where("DATE(arrival_date) + (freetime || ' days')::interval = ?", Date.current) }

  def total_containers
    [
      nbre_20pieds_sec,
      nbre_40pieds_sec,
      nbre_20pieds_frigo,
      nbre_40pieds_frigo,
      nbre_20pieds_special,
      nbre_40pieds_special
    ].compact.sum
  end

  def has_open_invoice?
    invoices.unpaid.exists?
  end

  def calculate_demurrage_amount
    total_containers * 80
  end
end
