class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day

  has_one_attached :image

  validates :name, :description, :price, :image, presence: true
  validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: "can't be blank" }
  validates :price, inclusion: { in: 300..9_999_999 }, numericality: { with: / \A [0-9]+ \z / }
end
