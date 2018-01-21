require 'open-uri'
require 'nokogiri'
require 'csv'

# multipage webscrapper

url = "http://thechive.com/page/1"

# nokogiri parses HTML and XML
page = Nokogiri::HTML(open(url))

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

last_number = pages.max.join.to_i

# incrementing/loop pages

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

#
CSV.open("./reports/theChive.csv", "w") do |file|
  file << ["Title", "Likes"]

  titles.length.times do |i|
    file << [titles[i], likes[i]]
  end
end
