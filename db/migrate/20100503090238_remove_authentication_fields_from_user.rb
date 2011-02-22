class RemoveAuthenticationFieldsFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :salt
    remove_column :users, :remember_token_expires_at
    remove_column :users, :crypted_password
    remove_column :users, :remember_token
  end

  def self.down
    add_column :users, :salt,                      :string,  :limit => 40
    add_column :users, :remember_token_expires_at, :datetime
    add_column :users, :crypted_password,          :string,  :limit => 40
    add_column :users, :remember_token,            :string,  :limit => 40
  end
end
