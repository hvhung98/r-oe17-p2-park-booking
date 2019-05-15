class SearchesController < ApplicationController
  def index
    q = params[:search]
    @items = Parking.search(name_or_address_cont: q).result
    respond_to do |format|
      format.js
      format.html
    end
  end
end
