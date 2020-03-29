class NprCliNewsReader::Scraper
  
  @@base_url = "https://www.npr.org"
  
  def self.scrape_articles_for_category(selected_category)
    if NprCliNewsReader::Article.all.detect {|article| article.category == selected_category}
      NprCliNewsReader::Article.scrape_articles_by_category
    else
      html = open("#{@@base_url}/sections/#{selected_category}")
      doc = Nokogiri::HTML(html)
      articles = doc.css('article.item')
      articles.each do |article|
        article_attributes = {
          category: selected_category.downcase,
          title: article.css('h2.title a').text.strip,
          teaser: article.css('p.teaser a').text.strip,
          article_url: article.css('h2.title a').attr('href').to_s.strip
        }
        NprCliNewsReader::Article.new(article_attributes)
      end
    end
    
  end
  
  def self.scrape_full_article(article)
    html = open (article.article_url)
    doc = Nokogiri::HTML(html)
    # discard the first p tag
    paragraphs = doc.css('#storytext > p')
    article.full_article = paragraphs
  end
  
end