class AddSaltToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :salt, :string
  end

  def self.down
    remove_column :employees, :salt
  end
end
