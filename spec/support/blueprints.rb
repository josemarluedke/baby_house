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
