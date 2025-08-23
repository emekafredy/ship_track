class Customer < ApplicationRecord
  has_many :bill_of_ladings
  has_many :invoices, through: :bill_of_ladings
end
