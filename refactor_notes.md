New notes for tomorrow from 3/26

Note 1 - Check if scraping for articles is neccessary, otherwise return articles with matching category.
  - When a categroy is selected check first if the Article @@all array is empty
    - If the @@all array is empty 
     - Scrape the selected category url and then create new articles and save them
    - elsif the @@all array is not empty
      - if @@all.include?(category) 
        - return the articles that have the selected article
      - if !@@all.include?(category)
        - Scrape the selected category url and then create new articles and save them

Note 2 - handle user input for article selection, then display the selected article.

  