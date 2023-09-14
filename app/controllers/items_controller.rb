class ItemsController < ApplicationController

  before_action :authenticate_user!, only: :new

  def index
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

  private

  def item_params
    params.require(:item).permit(:name, :price, :content, :category_id, :condition_id, :fee_id, :prefecture_id, :ship_day_id, :image).merge(user_id: current_user.id)
  end
  
end
