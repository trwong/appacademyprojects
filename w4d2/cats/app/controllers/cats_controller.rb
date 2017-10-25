class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.update(params[:id], cat_params)
    # if @cat.save
    redirect_to cat_url(@cat)
    # else
    #   flash.now[:errors] = @cat.errors.full_messages
    #   render :new
    # end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :color, :birth_date, :description, :sex)
  end
end
