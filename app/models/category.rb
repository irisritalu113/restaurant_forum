class Category < ApplicationRecord
  # 建立Model資料關聯
  validates_presence_of :name
  # dependent: :destroy，表示在刪除某筆 Category 資料時，需要一併刪除所有關聯的 Restaurant 資料
  # 如果分類下已有餐廳，就不允許刪除分類（刪除時拋出 Error)
  has_many :restaurants, dependent: :restrict_with_error
end