class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  # 制作ステータス => 0:製作不可 1:製作待ち 2:製作中 3:製作完了
  enum making_status: {
    unable_making: 0,
    waiting_making: 1,
    in_making: 2,
    finish_making: 3
  }
 
end