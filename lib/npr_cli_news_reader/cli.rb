class NprCliNewsReader::CLI 
  
  attr_accessor :done, :selected_category
  
  def initialize
    @categories = ["National", "World", "Politics", "Business", "Health", "Science", "Technology", "Race & Culture"]
    @done = false
  end
  
  def call
    
    # let the user select an article
    # display the full article.
    greet_user
    present_categories
    display_category_articles
    handle_article_selection
  end  
  
  def greet_user
    puts Rainbow("Hello fellow fact finder...").bright
    puts Rainbow("Welcome to the Npr Cli News Reader.").bright.fg(:green)
    puts "--------------------"
    sleep(1.5)
  end
  
  def present_categories
    puts Rainbow("Categories").bright
    puts "--------------------"
    @categories.each_with_index do |category, i|
      if i.even?
        puts Rainbow("#{i + 1}). #{category}").bright
      else
        puts Rainbow("#{i + 1}). #{category}").bright.fg(:green)
      end
    end
  end
  
  def valid_input?(user_input, collection)
    if user_input.to_i > 0 && user_input.to_i <= collection.size
      return true
    else
      return false
    end
  end
  
  def format_teaser(teaser_string)
    formatted_teaser = teaser_string.split(/\A.+[\u0095]\s/)[1]
    formatted_teaser
  end
  
  def display_category_articles
    
    puts Rainbow("Which Category would you like to see articles for?").bright
    puts "Use the numbers associated with the categories."
    category_input = gets.strip
    
    while !valid_input?(category_input, @categories)
    
      puts "Sorry, the input received is not valid to select a category"
      puts "Please enter a number 1-#{@categories.size}:"
      category_input = gets.strip  
      
    end
    
    @selected_category = @categories[category_input.to_i - 1].downcase
    
    puts Rainbow("#{@selected_category.capitalize} Category").bright
    puts "--------------------"
    NprCliNewsReader::Scraper.scrape_articles_for_category(@selected_category)
    NprCliNewsReader::Article.all.each_with_index do |article, i|
      formatted_teaser = format_teaser(article.teaser)
      if i % 2 == 0
        puts Rainbow("#{i + 1}").bright + ")." + Rainbow(" #{article.title}").bright
        puts
        puts Rainbow("#{formatted_teaser}")
        puts
        puts "--------------------"
        puts
      else
        puts Rainbow("#{i + 1}). #{article.title}").bright.fg(:green)
        puts
        puts Rainbow("#{formatted_teaser}").fg(:green)
        puts
        puts "--------------------"
        puts
      end
    end
  end
  
  def handle_article_selection
    # load up a sorted array of articles with the selected category matching
    # ask the user for input
    # send the selected article to the display_full_article insatnce method
    sorted_articles = NprCliNewsReader::Article.sort_articles_by_category(@selected_category)
    puts Rainbow("Which article would you like to see the full article for?").bright
    puts "Use the numbers associated with the articles."
    article_input = gets.strip
    
    while !valid_input?(article_input, sorted_articles)
      puts "Sorry, the input received is not valid to select an article"
      puts "Please enter a number 1-#{sorted_articles.size}:"
      article_input = gets.strip
    end
    
    article = sorted_articles[article_input.to_i - 1]
    
    NprCliNewsReader::Scraper.scrape_full_article(article)
    
    display_full_article(article)
    
  end
  
  def display_full_article(article)
    
    puts Rainbow("#{article.title}").bright
    puts "--------------------"
    article.full_article.each do |paragraph_node| 
      puts "\t#{paragraph_node.text}"
      puts "--------------------"
    end
    
  end
  
end