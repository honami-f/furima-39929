class OederPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture, :city, :street_address, :building, :phone_number

  with_options presence: true do
    validates :user_id, :item_id
    validates :post_code, :phone_number, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end
  validates :prefecture, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order_id, item_id: item_id, order_id: order_id, post_code: post_code, prefecture: prefecture, city: city, street_address: street_address, building: building, phone_number: phone_number)
  end

end