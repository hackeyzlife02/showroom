class EmployeesController < ApplicationController
  
  def show
    @employee = Employee.find(params[:id])
    @title = @employee.name
  end
  
  def new
    @title = "Register"
  end

end
