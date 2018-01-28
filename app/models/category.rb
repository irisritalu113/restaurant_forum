class Category < ApplicationRecord
  # 建立Model資料關聯
  has_many :restaurants
end