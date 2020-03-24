class NprCliNewsReader::CLI 
  
  attr_accessor :done, :selected_category
  
  @sorted_articles = []
  
  def initialize
    @categories = ["National", "World", "Politics", "Business", "Health", "Science", "Technology", "Race & Culture"]
    @done = false
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
    @categories.each_with_index {|category, i| puts "#{i + 1}.) #{Rainbow(category).bright}"}
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
      @selected_category = @categories[categories_index].downcase
      NprCliNewsReader::Article.find_or_create_articles(@selected_category)
      @sorted_articles = NprCliNewsReader::Article.sort_articles(@selected_category)
      display_articles
    end
  end
  
  def display_articles
    puts "----- #{Rainbow(@sorted_articles.first.category.capitalize).bright} Category -----"
    @sorted_articles.each_with_index do |article, i|
      sleep(0.5)
      puts "#{i + 1}). #{Rainbow(article.title).bright}"
      puts "#{article.short_description}"
      puts "-------------------"
    end
  end
  
  def handle_article_input(user_input)
    if valid_input?(user_input, @sorted_articles)
      article_index = user_input.to_i - 1
      selected_article = @sorted_articles[article_index]
      puts 'Loading...'
      full_article = NprCliNewsReader::Scraper.get_full_article(selected_article.article_url)
      selected_article.full_article = full_article
      sleep(2)
      display_selected_article(selected_article)
    end
  end
  
  def display_selected_article(article)
    puts '-------------------'
    puts Rainbow(article.title).bright
    article.full_article.each { |text| puts "#{text}\n"}
    puts '(END)'
  end
  
  def restart_or_exit(user_input)
    if user_input == 'home' 
      puts "Redisplaying categories"
      sleep(1)
    elsif user_input == 'exit'
      puts "Thanks for using NPR CLI News Reader."
      puts "Goodbye!"  
      @done = true
    end
  end
  
  
end