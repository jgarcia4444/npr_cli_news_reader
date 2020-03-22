class NprCliNewsReader::CLI 
  
  attr_accessor :articles
  
  def initialize
    @categories = ["National", "World", "Politics", "Business", "Health", "Science", "Technology", "Race & Culture"]
    @articles = []
  end
 
  
  def greeting
    puts
    puts "--------Hello fellow fact finder!--------"
    puts
    puts "---Welcome to the NPR CLI News Reader----"
    puts
  end
  
  def display_article_categories
    puts "----Article Categories----"
    @categories.each_with_index {|category, i| puts "#{i + 1}.) #{category}"}
  end
  
  def valid_input?(user_input, collection)
    if user_input.to_i > 0 && user_input.to_i <= collection.size
      return true
    else
      return false
    end
  end
  
  def handle_category_input(user_input)
    if valid_input?(user_input, @categories)
      categories_index = user_input.to_i - 1
      selected_category = @categories[categories_index].downcase
      @articles = NprCliNewsReader::Scraper.get_articles("/sections/#{selected_category}")
    end
  end
  
  def display_articles
    @articles.each_with_index do |article, i|
      puts "#{i + 1}). #{article.title}"
      puts "#{article.short_description}"
      puts "#{article.article_url}"
      puts "-------------------"
    end
  end
  
  def handle_article_input(user_input)
    if valid_input?(user_input, @articles)
      article_index = user_input.to_i - 1
      selected_article = @articles[article_index]
    end
  end
  
  
end