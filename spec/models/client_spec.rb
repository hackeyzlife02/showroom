# == Schema Information
#
# Table name: clients
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  phone      :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Client do
  
  before(:each) do
    @attr = { 
      :first_name => "Example", 
      :last_name => "Client", 
      :phone => "0123456789", 
      :email => "Client@example.com"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Client.create!(@attr)
  end
  
  it "should require a first name" do
    no_name_Client = Client.new(@attr.merge(:first_name => ""))
    no_name_Client.should_not be_valid
  end
  
  it "should require a last name" do
    no_name_Client = Client.new(@attr.merge(:last_name => ""))
    no_name_Client.should_not be_valid
  end
  
  it "should require a phone number" do
    no_name_Client = Client.new(@attr.merge(:phone => ""))
    no_name_Client.should_not be_valid
  end
  
  it "should require an email address" do
      no_email_Client = Client.new(@attr.merge(:email => ""))
      no_email_Client.should_not be_valid
  end
  
  it "should reject duplicate email addresses" do
      # Put a Client with given email address into the database.
      Client.create!(@attr)
      Client_with_duplicate_email = Client.new(@attr)
      Client_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      Client.create!(@attr.merge(:email => upcased_email))
      Client_with_duplicate_email.should_not be_valid
  end
  
  it "should accept valid email addresses" do
      addresses = %w[Client@foo.com THE_Client@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_Client = Client.new(@attr.merge(:email => address))
        valid_email_Client.should be_valid
      end
  end
  
  it "should reject invalid email addresses" do
      addresses = %w[Client@foo,com Client_at_foo.org example.Client@foo.]
      addresses.each do |address|
        invalid_email_Client = Client.new(@attr.merge(:email => address))
        invalid_email_Client.should_not be_valid
      end
  end
  
  it "should reject first names that are too long" do
      long_name = "a" * 51
      long_name_Client = Client.new(@attr.merge(:first_name => long_name))
      long_name_Client.should_not be_valid
  end
  
  it "should reject last names that are too long" do
      long_name = "a" * 51
      long_name_Client = Client.new(@attr.merge(:last_name => long_name))
      long_name_Client.should_not be_valid
  end
end
