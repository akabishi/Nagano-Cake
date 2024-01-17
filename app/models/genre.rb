class Genre < ApplicationRecord
   has_many :items, dependent: :destroy
     
   validates :name, presence: true, uniqueness: true, length: {in: 2..20}

end
