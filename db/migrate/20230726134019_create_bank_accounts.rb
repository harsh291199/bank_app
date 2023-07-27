class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.decimal :balance
      t.timestamps
    end
  end
end
