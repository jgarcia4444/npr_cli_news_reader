class NprCliNewsReader::CLI 
  
  attr_accessor :done, :selected_category
  
  def initialize
    @categories = ["National", "World", "Politics", "Business", "Health", "Science", "Technology", "Race & Culture"]
    @done = false
  end
  
  def call
    
    # let the user select a category 
    # use the selection to display the articles in that category
    # let the user select an article
    # display the full article.
    greet_user
    present_categories
    display_category_articles
    binding.pry
  end  
  
  def greet_user
    puts "Hello fellow fact finder..."
    puts "Welcome to the Npr Cli News Reader."
    puts "--------------------"
  end
  
  def present_categories
    puts Rainbow("Categories").bright
    @categories.each_with_index do |category, i|
      puts "#{Rainbow(i + 1).bright}). #{Rainbow(category).bright}"
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
    
    puts Rainbow("#{@categories[category_input.to_i - 1]}").bright + " Category"
    puts "--------------------"
    NprCliNewsReader::Scraper.scrape_articles_for_category(@categories[category_input.to_i - 1])
    
  end
  
  
end