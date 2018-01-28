class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name

# 建立Model資料關聯
  belongs_to :category, optional: true
end
