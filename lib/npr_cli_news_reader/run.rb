class NprCliNewsReader::Run
  def self.start
    cli = NprCliNewsReader::CLI.new
    while !cli.done
      cli.greeting
      cli.display_article_categories
      puts "Which category would you like to see news articles for?"
      puts "(Enter the # associated with the category)"
      category_input = gets.strip
      cli.handle_category_input(category_input)
      puts "Which article would you like to read?"
      puts "(Enter the number associated with the article):"
      selected_article = gets.strip
      cli.handle_article_input(selected_article)
      puts "Would you like to go back to the category selection or exit the program?"
      puts "(enter home or exit)"
      end_of_program_input = gets.strip.downcase
      cli.restart_or_exit(end_of_program_input)
    end
  end  
end