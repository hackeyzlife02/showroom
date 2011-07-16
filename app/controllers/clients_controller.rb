class ClientsController < ApplicationController
  
  def show
    @client = Client.find(params[:id])
    @title = @client.first_name + " " + @client.last_name
  end
  
  def new
    @client = Client.new
    @title = "Add Client"
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to @client, :flash => { :success => "Welcome to the Jungle!" }
    else
      @title = "Add Client"
      render 'new'
    end
  end

end
