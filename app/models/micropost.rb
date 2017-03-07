class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :image_size
  
  mount_uploader :image, ImageUploader

  private
  def image_size
    if image.size > 1.megabytes
      errors.add(:image, "1MB以下にして下さい")
    end
  end
  
end