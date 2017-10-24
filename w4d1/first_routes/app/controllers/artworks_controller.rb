class ArtworksController < ApplicationController
  def index
    user = User.find(params[:user_id])
    artworks = user.artworks
    shared_artworks = user.shared_artworks
    render json: artworks + shared_artworks
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    artwork = Artwork.find(params[:id])
    if artwork
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: 404
    end
  end

  def update
    artwork = Artwork.find(params[:id])
    artwork.update(artwork_params)
    render json: artwork
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.delete
    render json: artwork
  end

  private
  def artwork_params
    params.require(:artwork).permit(:artist_id, :title, :image_url)
  end
end
