class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  layout "portfolio"
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
  
  def index
    @portfolio_items = Portfolio.all
  end
  
  def angular
    @angular_portfolio_items = Portfolio.angular
  end
  
  def new
    @portfolio_items = Portfolio.new
    3.times { @portfolio_items.technologies.build }
  end
  
  def create
    @portfolio_items = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_items.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
  end
  
   def update
     
    respond_to do |format|
      if @portfolio_items.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'The record was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  def show
  end
  
  def destroy
      #Preform the lookup
      #Destroys the record
      @portfolio_items.destroy
      #Redirect
      respond_to do |format|
        format.html { redirect_to portfolios_url, notice: 'Post was removed.' }
    end
  end

private

  def portfolio_params
    params.require(:portfolio).permit(:title, 
                                      :subtitle, 
                                      :body,                        
                                      technologies_attributes: [:name]
                                      )
  end

  def set_portfolio_item
    @portfolio_items = Portfolio.find(params[:id])
  end
end
