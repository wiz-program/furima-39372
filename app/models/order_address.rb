class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token, :price

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "数字は半角入力、「-」を含めてください"}
    validates :city
    validates :house_number
    validates :user_id
    validates :item_id
    validates :token

    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "は半角入力、「-」は含めないでください"}
  end
  validates :prefecture_id, numericality: {other_than: 0, message: "を選択してください"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
        amount: price,  # 商品の値段
        card:   token,  # カードトークン
        currency: 'jpy'  # 通貨の種類（日本円）
      )
  end
end