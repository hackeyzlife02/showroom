require 'spec_helper'

describe Quote do
  before(:each) do
    @client = Factory(:client)
    @attr = { :title => "Incline", :notes => "Will need to purchase lots of dirt." }
  end
  
  it "should create a new instance given valid attributes" do
      @client.quotes.create!(@attr)
  end

  describe "client associations" do

    before(:each) do
      @quote = @client.quotes.create(@attr)
    end

    it "should have a client attribute" do
      @quote.should respond_to(:client)
    end

    it "should have the right associated client" do
      @quote.client_id.should == @client.id
      @quote.client.should == @client
    end
  end
  
  describe "validations" do
    
    it "should have a client id" do
      Quote.new(@attr).should_not be_valid
    end
    
    it "should require a nonblank title" do
      @client.quotes.build(:title => " ").should_not be_valid
    end
    
    it "should reject long titles" do
      @client.quotes.build(:title => "a" * 46).should_not be_valid
    end
    
    it "should require a nonblank note" do
      @client.quotes.build(:notes => " ").should_not be_valid
    end
    
    it "should reject long notes" do
      @client.quotes.build(:notes => "a" * 120).should_not be_valid
    end
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

