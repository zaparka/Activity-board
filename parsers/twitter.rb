
def twitter_messages(user_name, message_count)
  url_link ="http://api.twitter.com/1/statuses/user_timeline/#{user_name}.xml?count=#{message_count}"
  doc = Nokogiri::Slop( open(url_link) )

  messages = []
  doc.search('status').each do |item|
    text = item.search('text').text
    title = text.split
    title = title[0] + " " + title[1] + ' ...' if title.size >= 2
    title = title.to_s

    messages << {:title => title, :text => text, :published => item.created_at.text.sub('+0000', '')}
  end

  messages
end
