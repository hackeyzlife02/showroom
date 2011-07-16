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
      test_sign_in(@employee)
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

  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", 
                  :email => "",
                  :password => "",
                  :password_confirmation => "" }
      end
      
      it "should have the right title" do
        post :create, :employee => @attr
        response.should have_selector('title', :content => "Register Employee")
      end
      
      it "should render the 'new' page" do
        post :create, :employee => @attr
        response.should render_template('new')
      end
      
      it "should not create employee" do
        lambda do
          post :create, :employee => @attr
        end.should_not change(Employee, :count)
      end
      
    end     #end Failure
    
    describe "success" do
      
      before(:each) do
        @attr = { :name => "New Employee", 
                  :email => "newemployee@example.com",
                  :password => "foobar",
                  :password_confirmation => "foobar" }
      end
      
      it "should create a employee" do
        lambda do
          post :create, :employee => @attr
        end.should change(Employee, :count).by(1)
      end
      
      it "should redirect to the employee show page" do
        post :create, :employee => @attr
        response.should redirect_to(employee_path(assigns(:employee)))
      end
      
      it "should have a welcome message" do
        post :create, :employee => @attr
        flash[:success].should =~ /Welcome to the Jungle!/i
      end
      
    end     #end Success
    
  end       #end POST Create

  describe "GET 'edit'" do
    
    before(:each) do
      @employee = Factory(:employee)
      test_sign_in(@employee)
    end
    
    it "should be successful" do
      get :edit, :id => @employee
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @employee
      response.should have_selector('title', :content => "Edit Profile")
    end

  end       #end GET Edit

  describe "PUT 'update'" do
    
    before(:each) do
      @employee = Factory(:employee)
      test_sign_in(@employee)
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :email => "" }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @employee, :employee => @attr
        response.should have_selector('title', :content => "Edit Profile")
      end
      
      it "should have the right title" do
        put :update, :id => @employee, :employee => @attr
        response.should have_selector('title', :content => "Edit Profile")
      end
      
    end     #end failure
    
    describe "success" do
      
      before(:each) do
        @attr = { :name => "Jimmy Lutz", :email => "jlutz@example.com",
                          :password => "barbaz", :password_confirmation => "barbaz" }
      end
      
      it "should change the employee's attributes" do
        put :update, :id => @employee, :employee => @attr
        employee = assigns(:employee)
        @employee.reload
        @employee.name.should == employee.name
        @employee.email.should == employee.email
      end
      
      it "should redirect to the employee show page" do
        put :update, :id => @employee, :employee => @attr
        response.should redirect_to(employee_path(@employee))
      end
      
      it "should have a flash message" do
        put :update, :id => @employee, :employee => @attr
        flash[:success].should =~ /updated./i
      end
      
    end
      
  end       #end PUT update
  
  describe "authentication of edit/update pages" do

    before(:each) do
      @employee = Factory(:employee)
    end

    describe "for non-signed-in employees" do

      it "should deny access to 'edit'" do
        get :edit, :id => @employee
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @employee, :employee => {}
        response.should redirect_to(root_path)
      end
    end
    

    describe "for signed-in employees" do

      before(:each) do
        wrong_employee = Factory(:employee, :email => "employee@example.net")
        test_sign_in(wrong_employee)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @employee
        response.should redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        put :update, :id => @employee, :employee => {}
        response.should redirect_to(root_path)
      end
    end
    
  end       #End Authentication of edit/update pages
  
end
