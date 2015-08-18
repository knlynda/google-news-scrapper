require_relative 'pages/google_news_page'

news_file_name = 'news.yml'
news = GoogleNewsPage.new.news
puts "Store news to file #{news_file_name}"
File.open(news_file_name, 'w') { |file| file.write(news.to_yaml) }
