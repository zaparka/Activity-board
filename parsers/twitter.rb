
def twitter_messages(user_name, message_count)
  url_link ="http://api.twitter.com/1/statuses/user_timeline/#{user_name}.xml?count=#{message_count}"
  doc = Nokogiri::Slop( open(url_link) )
  
  messages = []
  doc.search('status').each do |item|
    text = item.search('text').text
    messages << {:text => text, :posted => item.created_at.text}
  end
  
  messages
end
