class QuotesController < ApplicationController
  before_filter :authenticate
  
  def index
    @title = "Client Quotes"
    @client = Client.find(params[:client])
    @quotes = @client.quotes.paginate(:page => params[:page], :per_page => 5)
  end
  
  def new
    @title = "New Quote"
    @client = client_account
    @quote = @client.quotes.new
  end

  def edit
    @quote = Quote.find(params[:id])
    @client = @quote.client
    @quote_item = @quote.quote_items.new
    @quote_items = @quote.quote_items.paginate(:page => params[:page], :per_page => 10)
    @title = "Edit Quote"
  end

  def show
    @quote = Quote.find(params[:id])
    @quote_items = @quote.quote_items.paginate(:page => params[:page], :per_page => 10)
    @client = @quote.client
    @title = @quote.qtitle
  end

  def create
    @client = client_account
    @quote = @client.quotes.build(params[:quote])
    if @quote.save
      flash[:success] = "New Quote Successfully Created!"
      redirect_to client_path(@client)
    else
      @title = "New Quote"
      render 'new'
    end
  end
  
  def destroy
  end
  
  def update
    @client = client_account
    @quote = @client.quotes.find(params[:id])
    if @quote.update_attributes(params[:quote])
      redirect_to @client, :flash => { :success => "Quote Updated!" }
    else
      @title = "Edit Quote"
      @quote_item = @quote.quote_items.new
      @quote_items = @quote.quote_items
      render 'edit'
    end
  end
  
  private
  
    def correct_quote_client
      @quote = Quote.find(params[:id])
      @client = @quote.client
      redirect_to edit_quote_path(@quote)
    end

end
