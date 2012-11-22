# encoding: utf-8

class ActivityImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :postgresql_lo
  # storage :fog

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  process :resize_to_fill => [500, 400]
  process :convert => 'jpg'

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
