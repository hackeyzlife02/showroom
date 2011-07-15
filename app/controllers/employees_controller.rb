class EmployeesController < ApplicationController
  
  def show
    @employee = Employee.find(params[:id])
  end
  
  def new
    @title = "Register"
  end

end
