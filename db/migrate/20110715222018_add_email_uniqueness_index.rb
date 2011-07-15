class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :clients, :email, :unique => true
    add_index :employees, :email, :unique => true
  end

  def self.down
    remove_index :clients, :email
    remove_index :employees, :email
  end
end
