class ClientsController < ApplicationController
  before_filter :authenticate
  
  def index
    @title = "All Clients"
    @clients = Client.paginate(:all, :page => params[:page], :per_page => 10)
  end
  
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

  def edit
    @client = Client.find(params[:id])
    @title = "Edit Client"
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      redirect_to @client, :flash => { :success => "Client Profile Updated!" }
    else
      @title = "Edit Client"
      render 'edit'
    end
  end
end
