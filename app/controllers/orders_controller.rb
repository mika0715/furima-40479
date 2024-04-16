class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :login_check, only: [:index, :create]
  before_action :contributor_confirmation, only: [:index, :create]
  before_action :item_sold_out, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit( :postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token] )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def login_check
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def contributor_confirmation
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def item_sold_out
    if @item.order.present?
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