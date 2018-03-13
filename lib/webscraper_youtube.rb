require 'open-uri'
require 'nokogiri'
require 'csv'

user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36"

# crawalling popular videos on youtube
url = "https://www.youtube.com/feed/trending"

# nokogiri parses HTML and XML
page = Nokogiri::HTML(open(url, 'User-Agent' => user_agent))

image_link = []
image_link = page.css('')


title = []
page.css('').each do |line|
  title << line.text
end


channel = []
page.css('').each do |line|
  channel << line.text
end

published_date = []
page.css('').each do |line|
  published_date << line.text
end

views = []
page.css('').each do |line|
  views << line.text
end

# storing the data to csv:
CSV.open("./reports/youtube.csv", "w") do |file|
  file << ["Image Link", "Title", "Channel", "Date", "Views"]

  end
end
