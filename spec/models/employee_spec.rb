# == Schema Information
#
# Table name: employees
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Employee do
  before(:each) do
    @attr = { 
      :name => "Example Employee",
      :email => "Employee@example.com"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Employee.create!(@attr)
  end
  
  it "should require a name" do
    no_name_Employee = Employee.new(@attr.merge(:name => ""))
    no_name_Employee.should_not be_valid
  end
  
  it "should reject names that are too long" do
      long_name = "a" * 51
      long_name_Employee = Employee.new(@attr.merge(:name => long_name))
      long_name_Employee.should_not be_valid
  end
  
  it "should require an email address" do
      no_email_Employee = Employee.new(@attr.merge(:email => ""))
      no_email_Employee.should_not be_valid
  end
  
  it "should reject duplicate email addresses" do
      # Put a Employee with given email address into the database.
      Employee.create!(@attr)
      Employee_with_duplicate_email = Employee.new(@attr)
      Employee_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      Employee.create!(@attr.merge(:email => upcased_email))
      Employee_with_duplicate_email.should_not be_valid
  end
  
  it "should accept valid email addresses" do
      addresses = %w[Employee@foo.com THE_Employee@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_Employee = Employee.new(@attr.merge(:email => address))
        valid_email_Employee.should be_valid
      end
  end
  
  it "should reject invalid email addresses" do
      addresses = %w[Employee@foo,com Employee_at_foo.org example.Employee@foo.]
      addresses.each do |address|
        invalid_email_Employee = Employee.new(@attr.merge(:email => address))
        invalid_email_Employee.should_not be_valid
      end
  end
end
