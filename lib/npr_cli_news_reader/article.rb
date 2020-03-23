class NprCliNewsReader::Article
  
  attr_accessor :category, :title, :short_description, :full_article, :article_url
  
  def initialize(article_attributes)
    article_attributes.each { |k, v| self.send("#{k}=", v.strip) }
  end
  
  
end