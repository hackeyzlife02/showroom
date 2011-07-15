class ClientsController < ApplicationController
  
  def show
    @client = Client.find(params[:id])
  end
  
  def new
    @title = "Add Client"
  end

end
