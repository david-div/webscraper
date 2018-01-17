require 'open-uri'
require 'nokogiri'
require 'csv'

# multipage webscrapper

url = "http://thechive.com/"

# nokogiri parses HTML and XML
page = Nokogiri::HTML(open(url))

title_css = "h3.post-title.entry-title.card-title"
likes_css = "span.card-count.icon-thumbsup.upvotes-count"

titles = []
page.css(title_css).each do |title|
  titles << title.text
end

likes = []
page.css(likes_css).each do |like|
  likes << like.text
end

CSV.open("theChive.csv", "w") do |file|
  file << ["Title", "Likes"]

  titles.length.times do |i|
    file << [titles[i], likes[i]]
  end
end
