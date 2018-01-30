class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name, :category_id

# 建立Model資料關聯
  belongs_to :category, optional: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  has_many :comments

end
