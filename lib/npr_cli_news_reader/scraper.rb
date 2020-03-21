


class NprCliNewsReader::Scraper
  
  attr_accessor :base_url
  
  
  # Return an array of articles, all attributes set except for full_article
  def self.get_articles(category_url)
    html = open("https://www.npr.org#{category_url}")
    doc = Nokogiri::HTML(html)
    category = category_url.split("/")[2]
    articles = doc.css("article.item")
    articles.first
  end
  
  #loop over article_nodes grabbing the relevant data for the Article attributes
  def get_article_attributes(article_nodes, category)
    
  end
  
end