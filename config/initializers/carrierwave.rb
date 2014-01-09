CarrierWave.configure do |config|
  config.storage = ENV['UPLOAD_TO_S3'] ? :fog : :file
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['AWS_ACCESS_KEY'],
    :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
  }
  config.fog_directory = ENV['FOG_DIRECTORY']
  config.enable_processing = false if Rails.env.test?
  config.fog_attributes = {
    'Cache-Control' => 'max-age=315576000'
  }
end
