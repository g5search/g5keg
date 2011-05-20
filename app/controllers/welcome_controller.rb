class WelcomeController < ApplicationController
  def index
    @currently_on_tap = Keg.on_tap.first
    @beers = Beer.all
  end
end
