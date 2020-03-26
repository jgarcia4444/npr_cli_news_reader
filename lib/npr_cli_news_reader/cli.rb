class NprCliNewsReader::CLI 
  
  attr_accessor :done, :selected_category
  
  def initialize
    @categories = ["National", "World", "Politics", "Business", "Health", "Science", "Technology", "Race & Culture"]
    @done = false
  end
  
  def call
    
    # greet the users and display the categories with numbers for selection
    # let the user select a category 
    # use the selection to display the articles in that category
    # let the user select an article
    # display the full article.
    greet_user
    present_categories
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
  
  
end