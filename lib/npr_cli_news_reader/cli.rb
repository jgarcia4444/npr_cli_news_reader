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
  
  def display_category_articles
    
    puts Rainbow("Which Category would you like to see articles for?").bright
    puts "Use the numbers associated with the categories."
    category_input = gets.strip
    
    while !valid_input?(category_input, @categories)
    
      puts "Sorry, the input received is not valid to select a category"
      puts "Please enter a number 1-8:"
      category_input = gets.strip  
      
    end
    
    puts Rainbow("#{@categories[category_input.to_i - 1]} Category").bright
    puts "--------------------"
    NprCliNewsReader::Scraper.scrape_articles_for_category(@categories[category_input.to_i - 1])
    # NprCliNewsReader::Article.sort_articles_by_category(@categories[category_input.to_i - 1]).each_with_index do |article, i|
    #   puts "#{i + 1})." + Rainbow("#{article.title}").bright
    # end
    NprCliNewsReader::Article.all.each_with_index do |article, i|
      if i % 2 == 0
        puts Rainbow("#{i + 1}").bright + ")." + Rainbow(" #{article.title}").bright
        puts
        puts Rainbow("#{article.teaser}").bright
        puts
        puts "--------------------"
        puts
      else
        puts Rainbow("#{i + 1}). #{article.title}").bright.fg(:green)
        puts
        puts Rainbow("#{article.teaser}").bright.fg(:green)
        puts
        puts "--------------------"
        puts
      end
    end
  end
end