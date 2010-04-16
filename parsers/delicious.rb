
def delicious_feeds(url_link)
  delicious_feeds = FeedTools::Feed.open(url_link)

  feeds = []
  delicious_feeds.items.each do |feed|
    feeds << {:title => feed.title, :url => feed.link, :published => feed.published.to_s.sub('UTC ', '')}
  end

  feeds
end