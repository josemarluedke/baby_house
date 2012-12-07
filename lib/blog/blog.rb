class Blog
  class << self
    def fetch_last_posts
      Rails.cache.fetch('blog_posts', expires_in: 20.minutes) do
        begin
          feed = Feedzirra::Feed.fetch_and_parse("http://babyhouse.posterous.com/rss.xml")
          feed.entries
        rescue
          []
        end
      end
    end
  end
end
