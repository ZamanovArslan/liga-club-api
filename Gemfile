source 'https://rubygems.org'

ruby '2.7.0'

gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'

gem 'bootsnap', '>= 1.4.2', require: false

# gem 'rack-cors'

group :development, :test do
  gem 'byebug'
  gem "rubocop"
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "rspec-rails"
  gem "rspec_api_documentation", git: "https://github.com/premiumparking/rspec_api_documentation.git"
end
