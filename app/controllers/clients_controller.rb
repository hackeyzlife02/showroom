class ClientsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, :only => :destroy
  def index
    @title = "All Clients"
    @clients = Client.paginate(:all, :page => params[:page], :per_page => 10)
  end
  
  def show
    @client = Client.find(params[:id])
    store_client @client
    @client_addrs = @client.client_addrs
    @client_addr = @client.client_addrs.first
    @quotes = @client.quotes.paginate(:page => params[:page], :per_page => 5)
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
    store_client @client
    @client_addrs = @client.client_addrs.all
    @client_addr = @client.client_addrs.find_by_id(1) unless @client_addrs.nil?
    @title = "Edit Client"
  end

  def update
    @client = Client.find(params[:id])
    @client_addrs = @client.client_addrs
    if @client.update_attributes(params[:client])
      redirect_to @client, :flash => { :success => "Client Profile Updated!" }
    else
      @title = "Edit Client"
      render 'edit'
    end
  end

  def destroy
    client = Client.find(params[:id])
    fname = client.first_name
    lname = client.last_name
    client.destroy
    flash[:success] = "#{fname} #{lname} successfully deleted."
    redirect_to clients_path
  end

  private
    def admin_user
      redirect_to(root_path) unless current_employee.admin?
    end
    
end
