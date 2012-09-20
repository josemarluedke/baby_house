begin
  ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['sendgrid_username'],
  :password       => ENV['sendgrid_password'],
  :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method = :smtp
rescue
  nil
end
