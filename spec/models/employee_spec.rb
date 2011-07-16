require 'spec_helper'

describe Employee do
  before(:each) do
    @attr = { 
      :name => "Example Employee",
      :email => "Employee@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
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
  
  describe "password validations" do
    
    it "should require a password" do
      Employee.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      Employee.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Employee.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      Employee.new(hash).should_not be_valid
    end
    
  end       #End Password Validations
  
  describe "password encryption" do
    
    before(:each) do
      @employee = Employee.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @employee.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password attribute" do
      @employee.encrypted_password.should_not be_blank
    end
    
    it "should have a salt" do
      @employee.should respond_to(:salt)
    end
    
    describe "has_password? method" do
      
      it "should exist" do
        @employee.should respond_to(:has_password?)
      end
      
      it "should return true if the passwords match" do
        @employee.has_password?(@attr[:password]).should be_true
      end
      
      it "should return false if the password don't match" do
        @employee.has_password?("invalid").should be_false
      end
      
    end
    
    describe "authenticate method" do
      
      it "should exist" do
        Employee.should respond_to(:authenticate)
      end
      
      it "should return nil on email/password mismatch" do
       Employee.authenticate(@attr[:email], "wrongpass").should be_nil 
      end
      
      it "should return nil for an email address with no client" do
        Employee.authenticate("bar@foo.com", @attr[:password]).should be_nil
      end
      
      it "should return the user on email/password match" do
        Employee.authenticate(@attr[:email], @attr[:password]).should == @employee
      end
      
      
    end
    
  end     #end Password Encryption
  
end

# == Schema Information
#
# Table name: employees
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

