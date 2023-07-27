require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  
  has_one :bank_account, dependent: :destroy
  has_many :transactions, through: :bank_account

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  after_create :assign_bank_account
  after_create :generate_unique_token

  def generate_unique_token
    update(unique_token: generate_random_token)
  end

  private

  def generate_random_token
    SecureRandom.urlsafe_base64(50)
  end

  def assign_bank_account
    create_bank_account(balance: 0)
  end
end
