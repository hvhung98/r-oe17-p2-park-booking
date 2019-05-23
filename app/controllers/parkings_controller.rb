class ParkingsController < ApplicationController
   def index
    q = params[:search]
    if q
      @parkings = Parking.search(name_or_address_cont: q).result
    else
      @parkings = Parking.all
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show

  end
end
