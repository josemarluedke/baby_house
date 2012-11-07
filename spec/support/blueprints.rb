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

