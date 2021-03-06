class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone, :limit => 8

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
