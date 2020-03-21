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
  
  def valid_category_input?(user_input)
    if user_input.to_i > 0 && user_input.to_i <= @categories.size
      return true
    else
      return false
    end
  end
  
  def handle_category_input(user_input)
    if valid_category_input?(user_input)
      categories_index = user_input.to_i - 1
      selected_category = @categories[categories_index].downcase
      @articles = NprCliNewsReader::Scraper.get_articles("sections/#{selected_category}")
    end
  end
  
  
end