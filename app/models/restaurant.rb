class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name, :category_id

# 建立Model資料關聯
  belongs_to :category, optional: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  # 當 Restaurant 物件被刪除時，順便刪除依賴的 Comment
  has_many :comments, dependent: :destroy

end
