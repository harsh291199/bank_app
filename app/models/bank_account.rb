class BankAccount < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates_numericality_of :balance, only_numeric: true, allow_nil: false
end
