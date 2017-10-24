class ArtworkSharesController < ApplicationController
  def create
    artworkshares = ArtworkShare.new(artwork_share_params)
    if artworkshares.save
      render json: artworkshares
    else
      render json: artworkshares.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artworkshares = ArtworkShare.find(params[:id])
    artworkshares.delete
    render json: artworkshares
  end

  private
  def artwork_share_params
    params.require(:artworkshares).permit(:artwork_id, :viewer_id)
  end
end
