require 'spec_helper'

describe "Employees" do
  
  describe "register" do

      describe "failure" do

        it "should not register a new employee" do
          lambda do
            visit register_path
            fill_in "Name",         :with => ""
            fill_in "Email",        :with => ""
            fill_in "Password",     :with => ""
            fill_in "Confirm Password", :with => ""
            click_button
            response.should render_template('employees/new')
            response.should have_selector("div#error_explanation")
          end.should_not change(Employee, :count)
        end
        
      end       #End Registration Failure
      
      describe "success" do

        it "should register a new employee" do
          lambda do
            visit register_path
            fill_in "Name",         :with => "Example Employee"
            fill_in "Email",        :with => "employee@example.com"
            fill_in "Password",     :with => "foobar"
            fill_in "Confirm Password", :with => "foobar"
            click_button
            response.should have_selector("div.flash.success",
                                          :content => "Welcome")
            response.should render_template('employees/show')
          end.should change(Employee, :count).by(1)
        end
      end       #End Registration Success
      
    end       #End Register
    
end
