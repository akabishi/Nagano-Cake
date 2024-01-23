class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  def customer_status
    if is_active == true
      "有効"
    else
      "退会"
    end
  end
  
  def full_name
    last_name + ' ' + first_name
  end
  
  def full_name_kana
    last_name_kana + ' ' + first_name_kana
  end
  
  def self.search_for(content)
    
    @customer = Customer.where(['first_name LIKE ? OR last_name LIKE ? ', "%#{content}%", "%#{content}%"])
  end
  
end
