class ActivityImage < ActiveRecord::Base
  belongs_to :activity
  attr_accessible :image, :image_cache, :activity_id
  mount_uploader :image, ActivityImageUploader
  validates :image, :activity_id, presence: true
  has_many :buy_photos, dependent: :destroy
  before_save do
   self.original_filename = self.image.original_file
  end
end
