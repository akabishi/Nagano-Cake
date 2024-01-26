class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :order_details

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre_id, presence: true
  validates :image, presence: true

  def get_image(width, height)
    if image.attached?
      image.variant(resize_to_fill: [width, height]).processed
    end
  end

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * amount
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial"
      @item = Item.where("name LIKE?","%#{word}%")
    end
  end
  
  def self.search_for(content)
    @item = Item.where("name LIKE ?", "%#{content}%")
  end
  
end
