class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :move_to_index_id_different, only: [:index, :create]
  before_action :move_to_index_sold, only: [:index, :create]

  def index
    @purchase_record_address = PurchaseRecordAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_record_address = PurchaseRecordAddress.new(order_params)
    if @purchase_record_address.valid?
      pay_item
      @purchase_record_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    @item = Item.find(params[:item_id])
    params.require(:purchase_record_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def move_to_index_id_different
    item = Item.find(params[:item_id])
    if  current_user.id == item.user.id
      redirect_to root_path
    end
  end

  def move_to_index_sold
    purchase_record = PurchaseRecord.includes(:item)
    item = Item.find(params[:item_id])
    if purchase_record.exists?(item: item.id) == true
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

end
