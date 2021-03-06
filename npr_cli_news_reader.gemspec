
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "npr_cli_news_reader/version"

Gem::Specification.new do |spec|
  spec.name          = "npr_cli_news_reader"
  spec.version       = NprCliNewsReader::VERSION
  spec.authors       = ["'Jake Garcia'"]
  spec.email         = ["'bballwiz4@gmail.com'"]

  spec.summary       = %q{"A CLI that allows users to read news articles from npr.org."}
  spec.description   = %q{"This Gem allows a user to choose from a list of news categories. The ClI then displays the articles from npr.org that are under the selected category. Then the user can select a specific article. Once an article is selected then the full article will be displayed. Once the user gets to the end of the article they have a choice to exit the program, return to the category selection, or return to the previous article selection."}
  spec.homepage      = "https://github.com/jgarcia4444/npr_cli_news_reader.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://RubyGems.org'

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/jgarcia4444/npr_cli_news_reader.git"
    spec.metadata["changelog_uri"] = "https://github.com/jgarcia4444/npr_cli_news_reader.git"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_dependency "rainbow"
end
