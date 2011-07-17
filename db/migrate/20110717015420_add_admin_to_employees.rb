class AddAdminToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :employees, :admin
  end
end
