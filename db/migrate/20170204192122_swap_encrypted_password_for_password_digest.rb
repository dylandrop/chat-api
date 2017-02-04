class SwapEncryptedPasswordForPasswordDigest < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :encrypted_password
    add_column :users, :password_digest, :string
  end
end
