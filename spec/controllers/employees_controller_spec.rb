require 'spec_helper'

describe EmployeesController do
  render_views
  
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
  
  describe "GET 'show'" do
    
    before(:each) do
      @employee = Factory(:employee)
    end
    
    it "should be successful" do
      get :show, :id => @employee
      response.should be_success
    end
    
    it "should find the right employee" do
      get :show, :id => @employee
      assigns(:employee).should == @employee
    end
    
    it "should have the right title" do
      get :show, :id => @employee
      response.should have_selector('title', :content => @employee.name)
    end
    
    it "should have the employees name" do
      get :show, :id => @employee
      response.should have_selector('h1', :content => @employee.name)
    end
    
    it "should have the right URL" do
      get :show, :id => @employee
      response.should have_selector('td>a',   :href     => employee_path(@employee))
    end
    
  end       #End GET Show

end
