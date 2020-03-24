class NprCliNewsReader::Article
  
  attr_accessor :category, :title, :short_description, :full_article, :article_url
  
  @@all = []
  
  def initialize(article_attributes)
    article_attributes.each { |k, v| self.send("#{k}=", v.strip) }
    @@all << self
  end
  
  def self.all 
    @@all
  end
  
  def self.find_by_category(filter)
    self.all.detect {|article| article.category == filter}
  end
  
  def self.find_or_create_articles(filter)
    if self.find_by_category(filter) == nil
      NprCliNewsReader::Scraper.get_articles("/sections/#{filter}")
    else
      self.sort_articles(filter)
    end
  end
  
  def self.sort_articles(filter)
    self.all.select {|article| article.category == filter}
  end
  
  
  
end