class AddApiAuthTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :api_auth_token, :string
    add_index :users, :api_auth_token, unique: true
  end
end
