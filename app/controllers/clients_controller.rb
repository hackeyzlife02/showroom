class ClientsController < ApplicationController
  
  def show
    @client = Client.find(params[:id])
    @title = @client.first_name + " " + @client.last_name
  end
  
  def new
    @title = "Add Client"
  end

end
