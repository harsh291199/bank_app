class Transaction < ApplicationRecord
  belongs_to :bank_account

  validates :transaction_type, :amount, presence: true
end
