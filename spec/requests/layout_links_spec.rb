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
end
