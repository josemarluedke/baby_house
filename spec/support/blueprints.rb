require 'machinist/active_record'

# Add your blueprints here.

Page.blueprint do
  title { "Page #{sn}" }
  body  { "Lorem ipsum..." }
end

Banner.blueprint do
  title { "Some title" }
  link_url { "http://example.com" }
  image { File.open("#{Rails.root}/spec/fixtures/images/image.jpg") }
end

Parent.blueprint do
  name {'Josemar Davi Luedke'}
  email {"josemarluedke#{sn}@gmail.com"}
  password {'josemar'}
  password_confirmation {'josemar'}
  confirmed_at { Date.today }
end

Student.blueprint do
  name {"Josemar Luedke Jr."}
end

Team.blueprint do
  code {"0001"}
  name {"Capoeira"}
  shift {"tarde"}
  level {"Maternal"}
end

Activity.blueprint do
  name {"Capoeira"}
  cover { File.open("#{Rails.root}/spec/fixtures/images/image.jpg") }
end

BuyPhoto.blueprint do
  activity_image
  parent
end

ActivityImage.blueprint do
  activity
  image { File.open(Rails.root.join('spec', 'fixtures', 'images', 'image.jpg')) }
end
