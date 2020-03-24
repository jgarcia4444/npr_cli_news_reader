require_relative './npr_cli_news_reader/article'
require_relative './npr_cli_news_reader/cli'
require_relative './npr_cli_news_reader/run'
require_relative './npr_cli_news_reader/scraper'
require 'open-uri'
require 'nokogiri'
require 'rainbow'


module NprCliNewsReader
  class Error < StandardError; end
  # Your code goes here...
end
