class ClientAddrsController < ApplicationController
  before_filter :authenticate, :only => [:create, :edit, :update, :new]
  
  def new
    @title = "Add Address for Client"
    @client = client_account
    @client_addr = @client.client_addrs.new
  end
  
  def create
    @client = client_account
    @client_addr = @client.client_addrs.build(params[:client_addr])
    if @client_addr.save
      flash[:success] = "Added Address for the Client"
      redirect_to client_account
    else
      @title = "Sign Up"
      render 'new'
    end
  end
  
  def edit
    @client = client_account
    @client_addr = @client.client_addrs.find_by_id(params[:id])
    @title = "Edit Client Address"
  end
  
  def update
    @client = client_account
    @client_addr = @client.client_addrs.find(params[:id])
    if @client_addr.update_attributes(params[:client_addr])
      redirect_to @client, :flash => { :success => "Address Updated!" }
    else
      @title = "Edit Client Address"
      render 'edit'
    end
  end
  
  def destroy
    @client = client_account
    @client_addr = @client.client_addrs.find_by_id(params[:id])
    @client_addr.destroy
    redirect_to @client
  end
end