class OrdersController < ApplicationController
  before_action :set_item, only: [:create, :index]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if !user_signed_in? || current_user.id == @item.user_id
      redirect_to root_path
    else
      @order_payment = OrderPayment.new
    end
  end

  def create
    @order_payment = OrderPayment.new(order_payment_params)
    if @order_payment.valid?
      pay_item
      @order_payment.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_payment_params
    params.require(:order_payment).permit(:post_code, :prefecture, :city, :street_address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_payment_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
