class VinsController < ApplicationController
  include VinsManager

  def index
    @vins = fetch_vin_information(params[:search].upcase) if params[:search]
  end
end
