class EmployeesController < ApplicationController
  before_filter :authenticate, :only => [:show, :edit]
  before_filter :correct_employee, :only => [:show, :edit, :update]
  
  def show
    @employee = Employee.find(params[:id])
    @title = @employee.name
  end
  
  def new
    @employee = Employee.new
    @title = "Register Employee"
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      sign_in @employee
      redirect_to @employee, :flash => { :success => "Welcome to the Jungle!" }
    else
      @title = "Register Employee"
      render 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @title = "Edit Profile"
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      flash[:success] = "Profile updated."
      redirect_to @employee
    else
      @title = "Edit Profile"
      render 'edit'
    end
  end

  private
  
    def correct_employee
      @employee = Employee.find(params[:id])
      redirect_to(root_path) unless current_employee?(@employee)
    end
end
