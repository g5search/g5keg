class WelcomeController < ApplicationController
  def index
    @currently_on_tap = Beer.currently_on_tap
    @beers = Beer.all
  end
end
