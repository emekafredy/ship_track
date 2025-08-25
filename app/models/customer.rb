class Customer < ApplicationRecord
  has_many :bill_of_ladings
  has_many :invoices, through: :bill_of_ladings

  validates :customer_code, length: { maximum: 20 }
  validates :name, presence: true, length: { maximum: 60 }
  validates :group_name, presence: true, length: { maximum: 150 }
end
