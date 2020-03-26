class NprCliNewsReader::Article
  
  attr_accessor :category, :title, :short_description, :full_article, :article_url, :author
  
  @@all = []
  
  def initialize(article_attributes)
    article_attributes.each { |k, v| self.send("#{k}=", v.strip) }
    @all << self
  end
  
  def self.all 
    @@all
  end
  
end