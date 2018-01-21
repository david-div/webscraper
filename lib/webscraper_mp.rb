require 'open-uri'
require 'nokogiri'
require 'csv'

# so the site thinks we're browsing, rather than a program
# browser user string, taken from:
# http://www.whatismyuseragent.net/
user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36"

# multipage webscrapper
url = "http://thechive.com/page/1"

# nokogiri parses HTML and XML
page = Nokogiri::HTML(open(url, 'User-Agent' => user_agent))

title_css = "h3.post-title.entry-title.card-title"
likes_css = "span.card-count.icon-thumbsup.upvotes-count"

pages_css = "nav.page-navi"
pages_css_aref = "nav.page-navi a"

# finding the max number shown on the page. Note, that on theChive, it doesn't
# show the full number of pages
# page.css(pages_css).each do |pages|
#   puts pages.text.scan(/[0-9]/).max
# end

titles = []
likes = []

pages = []
page.css(pages_css_aref).select do |page|
  pages << page.text.scan(/[0-9]/)
end

# not the last page number, only the last shown as an option on the website
# there are 1000+ pages
last_number = pages.max.join.to_i

# incrementing/loop pages
# going through each page, adding them to the array

last_number.times do |i|

  url = "http://thechive.com/page/#{i + 1}"
  page = Nokogiri::HTML(open(url))

  page.css(title_css).each do |title|
    titles << title.text
  end

  page.css(likes_css).each do |like|
    likes << like.text
  end

end

# savind in the reports direcory
CSV.open("./reports/theChive.csv", "w") do |file|
  file << ["Title", "Likes"]

  titles.length.times do |i|
    file << [titles[i], likes[i]]
  end
end
