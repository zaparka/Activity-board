require 'nokogiri'
require 'open-uri'

def get_delicious_feeds(url_link)
  doc = Nokogiri::Slop( open(url_link) )
  @feeds = []
  doc.search('item').each do |item|
    @feeds << {:title => item.title.text, :url => item.link.next.text, :pubdate => item.pubdate.text}
  end
  @feeds
end