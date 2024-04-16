class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :login_check, only: [:index, :create]
  before_action :contributor_confirmation, only: [:index, :create]
  before_action :item_sold_out, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
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
    Payjp.api_key = "sk_test_92e3c5dcf6bb33167a12286e"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end