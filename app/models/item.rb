class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :fee
  belongs_to :prefecture
  belongs_to :ship_day

  belongs_to :user
  has_one_attached :image
  has_one :order

  with_options presence: true do
    validates :image
    validates :name, length: {maximum: 40}
    validates :content, length: {maximum: 1000}
    validates :category_id
    validates :condition_id
    validates :fee_id
    validates :prefecture_id
    validates :ship_day_id
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :condition_id
    validates :fee_id
    validates :prefecture_id
    validates :ship_day_id
  end

  with_options presence: true, format: {with: /\A[0-9]+\z/} do
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999}
  end
  

end