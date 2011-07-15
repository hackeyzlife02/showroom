require 'spec_helper'

describe EmployeesController do

  describe "GET 'new'" do
    
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Register")
    end
    
  end       #End GET new

end
