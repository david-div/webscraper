require 'mechanize'

# sraping result of searched sites once entered in a form

agent = Mechanize.new

page = agent.get('http://www.google.com')

# form name
google_form = page.form('f')

# q is the name of the input
# <input name='q'>
google_form.q = 'youtube'

page = agent.submit(google_form)

# when searched in google
# <h3 class='r'>
youtube_link = 'h3.r'

page.search(youtube_link).each do |link|
  puts link.content
end
