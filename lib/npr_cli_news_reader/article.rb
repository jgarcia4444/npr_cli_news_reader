class NprCliNewsReader::Article
  
  attr_accessor :category, :title, :short_description, :full_article
  
  def initialize(article_attributes)
    article_attributes.each { |k, v| self.send("#{k}=", v) }
  end
  
  
end