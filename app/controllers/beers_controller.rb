class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end
end
