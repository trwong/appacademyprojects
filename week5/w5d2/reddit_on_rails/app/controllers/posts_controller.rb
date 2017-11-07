class PostsController < ApplicationController

  before_action :ensure_owner, only: [:edit, :update]

  def ensure_owner
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      flash.now[:errors] = ["Must be the creator of the post to modify it"]
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    p "=========="
    p params
    @post.sub_id = 1
    # fail
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
