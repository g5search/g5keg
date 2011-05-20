class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def rate
    @beer = Beer.find(params[:id])
    @beer.rate_it(params[:rating], current_user)
    redirect_to :back
  end
end
