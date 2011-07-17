class Setnotedefault < ActiveRecord::Migration
  def self.up
    change_column_default(:quotes, :notes, 'There are no notes')
  end

  def self.down
    change_column_default(:quotes, :notes, nil)
  end
end
