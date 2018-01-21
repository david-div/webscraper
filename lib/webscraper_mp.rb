require 'open-uri'
require 'nokogiri'
require 'csv'

# multipage webscrapper

url = "http://thechive.com/"

# nokogiri parses HTML and XML
page = Nokogiri::HTML(open(url))

title_css = "h3.post-title.entry-title.card-title"
likes_css = "span.card-count.icon-thumbsup.upvotes-count"

pages_css = "nav.page-navi"

# finding the max number shown on the page. Note, that on theChive, it doesn't
# show the full number of pages
page.css(pages_css).each do |pages|
  puts pages.text.scan(/[0-9]/).max
end

titles = []
page.css(title_css).each do |title|
  titles << title.text
end

likes = []
page.css(likes_css).each do |like|
  likes << like.text
end
#
# pages = []
# page.css()
#
#
CSV.open("./reports/theChive.csv", "w") do |file|
  file << ["Title", "Likes"]

  titles.length.times do |i|
    file << [titles[i], likes[i]]
  end
end
