class VinsController < ApplicationController
  include VinsManager

  def index
    @vin = check_vin(params[:search].upcase) if params[:search]
    x=1
  end
end
