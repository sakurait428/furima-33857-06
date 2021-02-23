class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :purchase_record_set, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index_id_different, only: [:edit, :update, :destroy]
  before_action :move_to_index_sold, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
    @purchase_record = PurchaseRecord.includes(:item)
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

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def purchase_record_set
    @purchase_record = PurchaseRecord.includes(:item)
  end

  def move_to_index_id_different
    unless  current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def move_to_index_sold
    if @purchase_record.exists?(item_id: @item.id) == true
      redirect_to root_path
    end
  end

end