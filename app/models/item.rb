class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :fee
  belongs_to :prefecture
  belongs_to :ship_day

  belongs_to :user
  has_one_attached :image

  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "must be 300 ~ 9,999,999 and half width" }, format: { with: /\A[0-9]+\z/ }
  validates :name, presence: true, length: {maximum: 40}
  validates :content, presence: true, length: {maximum: 1000}
  validates :image, presence: true 
  validates :category_id, :condition_id, :fee_id, :prefecture_id, :ship_day_id, numericality: { other_than: 0 , message: "can't be blank" } 
end
