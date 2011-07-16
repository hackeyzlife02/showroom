class EmployeesController < ApplicationController
  
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

end
