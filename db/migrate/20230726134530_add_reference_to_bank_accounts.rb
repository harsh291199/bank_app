class AddReferenceToBankAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :bank_accounts, :user_id, :integer, foreign_key: true
  end
end
