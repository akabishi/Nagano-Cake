class Address < ApplicationRecord
  belongs_to :customer

    validates :postal_code, presence: true
    validates :address, presence: true
    validates :name, presence: true

    # options_from_collection_for_select に直接「郵便番号 住所 宛名」を書けない
    # ので、これらを表示するためのメソッドをモデルに記入する
    def address_display
      '〒' + postal_code + ' ' + address + ' ' + name
    end

end
