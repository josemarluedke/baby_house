require 'machinist/active_record'

# Add your blueprints here.

Page.blueprint do
  title { "Page #{sn}" }
  body  { "Lorem ipsum..." }
end
