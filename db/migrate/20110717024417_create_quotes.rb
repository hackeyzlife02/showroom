class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.string :title
      t.string :notes
      t.integer :client_id

      t.timestamps
    end
    add_index :quotes, :client_id
    add_index :quotes, :created_at
  end

  def self.down
    drop_table :quotes
  end
end
