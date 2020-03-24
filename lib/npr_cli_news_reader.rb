require_relative "./npr_cli_news_reader/version"
require_relative "./npr_cli_news_reader/cli"
require_relative "./npr_cli_news_reader/scraper"
require_relative "./npr_cli_news_reader/article"
require 'open-uri'
require 'nokogiri'
require 'rainbow'
require 'pry'

module NprCliNewsReader
  class Error < StandardError; end
  # Your code goes here...
end
