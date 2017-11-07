class SubsController < ApplicationController

  before_action :ensure_moderator, only: [:edit, :update]

  def ensure_moderator
    @sub = Sub.find(params[:id])
    unless @sub.user_id == current_user.id
      flash.now[:errors] = ["Must be the creator/mod of the sub to modify it"]
      render :edit
    end
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
