class NprCliNewsReader::CLI 
  
  attr_accessor :selected_category, :done
  
  def initialize
    @done = false
    @categories = ["National", "World", "Politics", "Business", "Health", "Science", "Technology", "Race & Culture"]
  end

  def call 
    greet_user
    present_categories
    handle_category_input
    handle_article_selection
    display_app_end_user_options
    while @done == false
      user_input = gets.strip
      if user_input.downcase == 'category'
        go_back_to_category_selection
      elsif user_input.downcase == 'article'
        go_back_to_articles
      else
        puts Rainbow('Thank you for using Npr CLI News Reader!').bright.fg(:white)
        puts Rainbow('Goodbye!').bright.fg(:green)
        @done = true
      end
    end
  end

  def go_back_to_articles
    display_category_articles
    handle_article_selection
    display_app_end_user_options
  end


  def go_back_to_category_selection
    present_categories
    handle_category_input
    handle_article_selection
    display_app_end_user_options
  end

  def display_app_end_user_options
    puts Rainbow("What would you like to do?").bright.fg(:white)
    puts "#{Rainbow('Exit Program:').bright.fg(:white)} #{Rainbow('exit').bright.fg(:green)}"
    puts "#{Rainbow('Go back to Category Selection:').bright.fg(:white)} #{Rainbow('category').bright.fg(:green)}"
    puts "#{Rainbow('Go back to article selection:').bright.fg(:white)} #{Rainbow('article').bright.fg(:green)}"
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
  
  def handle_category_input
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
    display_category_articles
  end
  
  def display_category_articles
    NprCliNewsReader::Article.sort_articles_by_category(@selected_category).each_with_index do |article, i|
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
    # puts Rainbow("Would you like to see the article on your default web browse? (y/n):").bright
    # user_input = gets.strip
    # if ["yes, y"].include?(user_input.downcase)
    #   system("open #{article.article_url}")
    # end
  end
  
end