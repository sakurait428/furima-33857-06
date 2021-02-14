class ItemsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all
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
    @category = Category.find(@item.category_id)
    @sales_status = SalesStatus.find(@item.sales_status_id)
    @shipping_fee_status = ShippingFeeStatus.find(@item.shipping_fee_status_id)
    @prefecture = Prefecture.find(@item.prefecture_id)
    @scheduled_delivery = ScheduledDelivery.find(@item.scheduled_delivery_id)
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end