class KegsController < ApplicationController
  def rotate
    new_keg = Keg.create(:beer_id => params[:beer_id])
    Keg.rotate(new_keg)
    flash[:notice] = 'Keg rotated'
    redirect_to :back
  end
end
