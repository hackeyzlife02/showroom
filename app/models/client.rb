require 'digest'

class Client < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :phone, :email
  has_many :client_addrs, :dependent => :destroy
  has_many :quotes, :dependent => :destroy
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :first_name,  :presence => true,
                          :length => { :maximum => 50 }
  
  validates :last_name,   :presence => true,
                          :length => { :maximum => 50 }
  
  validates :phone,       :presence => true
  
  validates :email,       :presence => true,
                          :format => { :with => email_regex },
                          :uniqueness => { :case_sensitive => false }
  

end

# == Schema Information
#
# Table name: clients
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  phone      :integer(8)
#  created_at :datetime
#  updated_at :datetime
#

