
def delicious_feeds(url_link)
  doc = Nokogiri::Slop( open(url_link) )
  feeds = []
  doc.search('item').each do |item|
    feeds << {:title => item.title.text, :url => item.link.next.text, :published => item.pubdate.text.sub('+0000', '')}
  end

  feeds
end