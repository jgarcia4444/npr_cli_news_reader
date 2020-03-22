1


class NprCliNewsReader::Scraper
  
  # Return an array of articles, all attributes set except for full_article
  def self.get_articles(category_url)
    html = open("https://www.npr.org#{category_url}")
    doc = Nokogiri::HTML(html)
    category = category_url.split("/")[2]
    articles = doc.css("article.item")
    articles_with_attributes = self.get_and_set_article_attributes(articles, category)
    articles_with_attributes
  end
  
  #loop over article_nodes grabbing the relevant data for the Article attributes
  def self.get_and_set_article_attributes(article_nodes, category)
    articles_with_attributes = []
    article_nodes.each do |article|
      anchor_tag = article.css('.teaser a')
      article_attributes = {
        category: category,
        title: article.css('.title').text,
        short_description: article.css('.teaser').text,
        article_url: anchor_tag.attribute('href').to_s
      }
      new_article = NprCliNewsReader::Article.new(article_attributes)
      articles_with_attributes << new_article
    end
    articles_with_attributes
  end
  
  def self.get_full_article(article_url)
    html = open(article_url)
    doc = Nokogiri::HTML(html)
    full_article_container = doc.css('#storytext')
    content = full_article_container.css('p')
    content
  end
  
end