class LikesController < ApplicationController
  def index
    if params[:user_id]
      likes = Like.find_by(user_id: params[:user_id])
    elsif params[:artwork_id]
      likes = Like.find_by(artwork_id: params[:artwork_id])
    elsif params[:comment_id]
      likes = Like.find_by(comment_id: params[:comment_id])
    else
      likes = Like.all
    end
    render json: likes
  end


  def create
    like = Like.new(like_params)
    if like.save
      render json: like
    else
      render json: like.errors.full_messages
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.delete
    render json: like
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :artwork_id, :comment_id)
  end
end
