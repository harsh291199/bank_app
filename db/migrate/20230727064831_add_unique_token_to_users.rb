class AddUniqueTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :unique_token, :string
  end
end
