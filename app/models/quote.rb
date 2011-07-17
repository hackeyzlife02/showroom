class Quote < ActiveRecord::Base
  attr_accessible :title, :notes
  
  belongs_to :client
  
  has_many :quote_items
  
  default_scope :order => 'quotes.updated_at DESC'
  
  validates :title,  :presence => true,
                      :length => { :maximum => 45 }
  
  validates :notes,  :length => { :maximum => 120 }

  validates :client_id, :presence => true
  
  def total
    quote_items.inject(0) {|sum, n| n.price * n.qty + sum}
  end
end

# == Schema Information
#
# Table name: quotes
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  notes      :string(255)
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

