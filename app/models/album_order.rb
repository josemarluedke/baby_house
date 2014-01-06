class AlbumOrder < ActiveRecord::Base
  belongs_to :parent
  has_many :buy_photos
  attr_accessible :exported

  validates :parent, presence: true

  def purchase
    self.finished_at = DateTime.now
    create_compact_file
    save
  end

  private

  def create_compact_file
    self.filename = "#{id}_#{finished_at.strftime("%d-%m-%Y-%H-%M-%S")}_#{SecureRandom.hex}.zip"
    create_zip
  end

  def create_zip
  end
end
