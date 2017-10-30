class CatRentalRequestsController < ApplicationController

  def new
    @cat_rental_requests = CatRentalRequest.all
    @cat_rental_request = CatRentalRequest.new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    if @cat_rental_request.save
      redirect_to cats_url
    else
      render :new
    end
  end

  private
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
