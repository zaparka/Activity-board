
def github(user_name, api_token)
  feed_url = "http://github.com/#{user_name}.private.actor.atom?token=#{api_token}"
  github_feed = FeedTools::Feed.open(feed_url)

  commits = []
  github_feed.items.each do |item|
    description = item.description[/<blockquote.+<\/blockquote>/]

    if description.nil?
      description = ""
    else
      description = description.sub(/<blockquote>/,'').sub(/<\/blockquote>/,'') 
    end

    commits << {:title => item.title, :description => description, :published => item.published.to_s}
    break if commits.size == 3
  end

  commits
end