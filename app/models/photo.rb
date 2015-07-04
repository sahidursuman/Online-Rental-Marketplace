class Photo < ActiveRecord::Base
  belongs_to :item
  validates :title, presence: true
  mount_uploader :image, ImageUploader
end
