class KegsController < ApplicationController
  def rotate
    new_keg = Keg.create(params[:keg])
    Keg.rotate(new_keg)
    flash[:notice] = 'Keg rotated'
    redirect_to :back
  end
end
