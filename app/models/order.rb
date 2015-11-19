class Order < ActiveRecord::Base
  PAYMENT_TYPES = %w{現金 クレジットカード 注文書 コンビニ決済}
  has_many :line_items, dependent: :destroy

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
      #↑item.order_id = id と同じようなもの
    end
  end
end
