require 'spec_helper'

describe "Clients" do
  before(:each) do
    @employee = Factory(:employee)
    visit signin_path
    fill_in :email,    :with => @employee.email
    fill_in :password, :with => @employee.password
    click_button
  end
  
  describe "add client" do
    
      describe "failure" do
        
        it "should not add a new client" do
          lambda do
            
            visit addclient_path
            
            fill_in "First name",   :with => ""
            fill_in "Last name",    :with => ""
            fill_in "Email",        :with => ""
            fill_in "Phone",        :with => ""
            click_button
            response.should render_template('clients/new')
            response.should have_selector("div#error_explanation")
          end.should_not change(Client, :count)
        end
        
      end       #End Registration Failure
      
      describe "success" do
        
        it "should add a new client" do
          lambda do
            visit addclient_path
            fill_in "First name",   :with => "Example"
            fill_in "Last name",   :with => "Client"
            fill_in "Email",        :with => "client@example.com"
            fill_in "Phone",   :with => "0123456789"
            click_button
            response.should have_selector("div.flash.success",
                                          :content => "Welcome")
            response.should render_template('clients/show')
          end.should change(Client, :count).by(1)
        end
      end       #End Registration Success
  end       #End Register

  
end
