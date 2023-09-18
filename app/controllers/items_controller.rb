class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :comfirm_user, only: [:edit, :update, :destroy]
  before_action :comfirm_sold_out?, only: :edit

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
    
  end

  def edit
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def update
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

  def set_item
    @item = Item.find(params[:id])
  end

  def comfirm_user
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def comfirm_sold_out?
    if @item.order.present?
      redirect_to root_path
    end
  end
end
