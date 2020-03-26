Refactor notes round 1
  - Executable should have one method call in it
    - NprCliNewsReader::CLI.new.call 
  
  - Take the functionality from run.rb and place it into a call instance method in the CLI class
  
  - There is an error when trying to run the console for the project
  
  - Take the article creation out of the cli.
    - Move this functionality into the scraper class
    - When a category is selected hand off to the scaper, then have the scraper return the data found to the article class, which then creates articles and stores them.

  