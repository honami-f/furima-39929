class OrdersController < ApplicationController
  before_action :set_item, only: [:create, :index]

  def index
    if !user_signed_in? || current_user.id == @item.user_id
      redirect_to root_path
    else
      @order_payment = OrderPayment.new
    end
  end

  def create
    @order_payment = OrderPayment.new(order_params)
    if @order_payment.valid?
      @order_payment.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_payment).permit(:post_code, :prefecture, :city, :street_address, :building, :phone_number, :price).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
