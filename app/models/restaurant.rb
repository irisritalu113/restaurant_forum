class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name, :category_id

# 建立Model資料關聯
  belongs_to :category, optional: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  # 當 Restaurant 物件被刪除時，順便刪除依賴的 Comment
  has_many :comments, dependent: :destroy

  # 「餐廳被很多使用者收藏」的多對多關聯
  # 將關聯名稱自訂為 :favorited_users
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # 如果有在 favorites table 上找到相符的資料，就代表「使用者已經收藏過這家餐廳」。
  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

end
