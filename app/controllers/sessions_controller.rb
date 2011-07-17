class SessionsController < ApplicationController
  
  def new
    @title = "Sign in"
  end
  
  def create
    employee = Employee.authenticate( params[:session][:email],
                                  params[:session][:password] )
    
    if employee.nil?
      flash.now[:error] = "Invalid email/password combination"
      @title = "Sign in"
      render 'new'
    else
      sign_in employee
      store_client nil
      redirect_back_or employee
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
