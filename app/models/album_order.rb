require 'zip'

class AlbumOrder < ActiveRecord::Base
  belongs_to :parent
  has_many :buy_photos
  has_many :activity_images, :through => :buy_photos
  attr_accessible :exported

  validates :parent, presence: true

  ZIP_LOCATION = Rails.root.join('public', 'zip')

  def purchase
    return false unless buy_photos.any? && finished_at.nil?
    self.finished_at = DateTime.now
    create_zip
    save
  end

  private

  def create_zip
    folder_name = "#{id}_#{finished_at.strftime("%d-%m-%Y_%H-%M-%S")}_#{SecureRandom.hex}"
    self.filename = "#{folder_name}.zip"
    images = buy_photos.
      map(&:activity_image).
      map{ |activity_image| activity_image.image.file.file }

    Zip::File.open(ZIP_LOCATION.join("#{folder_name}.zip").to_s, Zip::File::CREATE) do |zipfile|
      images.each do |file|
        zipfile.add("#{folder_name}/#{file.split('/').last}", file)
      end
    end
  end
end
