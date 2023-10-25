class OrderPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture, :city, :street_address, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id, :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: {with: /\A[0-9]{10,11}\z/, message: "is invalid."}
    validates :token, presence: true
  end
  validates :prefecture, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order.id, post_code: post_code, prefecture_id: prefecture, city: city, street_address: street_address, building: building, phone_number: phone_number)
  end

end
