class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  # def destroy
    # @item = Item.find(params[:id])
    # unless @item.user_id == current_user.id
    #   redirect_to root_path
    # end
    # @item.destroy
    # redirect_to root_path

  # end

  def update
    @item = Item.find(params[:id])
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
    if @item.update(item_params)
    redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :content, :category_id, :condition_id, :fee_id, :prefecture_id, :ship_day_id, :image).merge(user_id: current_user.id)
  end
  
end
