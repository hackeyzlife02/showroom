require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Home")
    end

    it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end

    it "should have an About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end

    it "should have a registration page at '/register'" do
      get '/register'
      response.should have_selector('title', :content => "Register")
    end
    
    it "should have a add client page at '/addclient'" do
      get '/addclient'
      response.should have_selector('title', :content => "Add Client")
    end
    
    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "Register"
      response.should have_selector('title', :content => "Register")
      visit root_path
      click_link "Add Client"
      response.should have_selector('title', :content => "Add Client")
    end
    
    describe "when not signed in" do
      it "should have a signin link" do
        visit root_path
        response.should have_selector("a", :href => signin_path,
                                           :content => "Sign in")
      end
    end

    describe "when signed in" do

      before(:each) do
        @employee = Factory(:employee)
        visit signin_path
        fill_in :email,    :with => @employee.email
        fill_in :password, :with => @employee.password
        click_button
      end

      it "should have a signout link" do
        visit root_path
        response.should have_selector("a", :href => signout_path,
                                           :content => "Sign out")
      end

      it "should have a profile link" do
        visit root_path
        response.should have_selector("a", :href => employee_path(@employee),
                                           :content => "Profile")
      end

      it "should have a settings link" do
        visit root_path
        response.should have_selector("a",  :href => edit_employee_path(@employee),
                                            :content => "Settings")
      end

      it "should have a clients link" do
        visit root_path
        response.should have_selector("a",  :href => clients_path,
                                            :content => "Clients")
      end
    end       #End When Signed In
end
