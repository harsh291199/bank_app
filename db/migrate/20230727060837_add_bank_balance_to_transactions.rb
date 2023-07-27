class AddBankBalanceToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :bank_balance, :decimal
  end
end
