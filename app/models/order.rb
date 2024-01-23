class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  # enum の定義
  enum payment_method: { credit_card: 0, transfer: 1 }

  # 注文ステータス
  enum status: {
    awaiting_payment: 0,
    payment_confirmed: 1,
    making: 2,
    shipping_in_process: 3,
    shipped: 4
  }

end
