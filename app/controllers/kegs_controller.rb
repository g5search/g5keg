class KegsController < ApplicationController
  def rotate
    new_keg = Keg.create(params[:keg])
    Keg.rotate(new_keg)
    flash[:notice] = 'Keg rotated'
    redirect_to :back
  end

  def current_weight
    Keg.current.update_attribute(:current_weight, params[:kg])
    render :nothing => true
  end
end
