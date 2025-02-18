class AddAuthFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :password_digest, :string, null: false
    add_column :users, :refresh_token, :string, null: true

    add_index :users, :refresh_token, unique: true
  end
end
