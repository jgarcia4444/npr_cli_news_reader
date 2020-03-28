class NprCliNewsReader::Article
  
  attr_accessor :category, :title, :teaser, :full_article, :article_url, :author, :date
  
  @@all = []
  
  def initialize(article_attributes)
    article_attributes.each { |k, v| self.send("#{k}=", v.strip) }
    @@all << self
  end
  
  def self.all 
    @@all
  end
  
  def add_full_article(full_article)
    self.full_article = full_article
  end
  
  def self.sort_articles_by_category(filter)
    self.all.select {|article| article.category == filter.downcase}
  end
  
end