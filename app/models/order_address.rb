class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :block, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "is invalid."}
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}

  def save
    # 注文情報を保存し、変数orderに代入する
    order = Order.create( user_id: user_id, item_id: item_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, order_id: order.id)
  end
end