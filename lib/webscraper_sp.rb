require 'open-uri'
require 'nokogiri'
require 'csv'

url = "http://www.asos.com/men/shoes-boots-trainers/cat/?cid=4209&nlid=mw%7Cshoes%7Cshop%20by%20product&page=1"

# nokogiri parses HTML and XML
page = Nokogiri::HTML(open(url))

# puts page.css('div.centered-row').text
#
#
# page.css('div._2Raol8i').each do |line|
#   puts line.text
# end
#
# # span with priceSale class within a div with prices class
# puts page.css('a._3x-5VWa p._6RF5CVD span._342BXW_').text
#
# # incepted classes:
# page.css('a._3x-5VWa p._6RF5CVD span._342BXW_').each do |price|
#   puts price.text
# end

# shows boots and trainers:
shoes = []
page.css('div._2Raol8i').each do |line|
  shoes << line.text
end

price = []
page.css('a._3x-5VWa p._6RF5CVD span._342BXW_').each do |line|
  price << line.text
end

# # storing the data to csv:
CSV.open("./reports/Asos_shoes.csv", "w") do |file|
  # header names
  file << ["Product Name", "Price"]

  # how many there are, each time adding them to the file
  shoes.length.times do |i|
    file << [shoes[i], price[i]]
  end
end
