class HomesController < ApplicationController
  def index
    @place = Place.new
  end
end
