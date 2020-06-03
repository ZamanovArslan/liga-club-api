source "https://rubygems.org"

ruby "2.7.0"

gem "pg"
gem "puma"
gem "rails", "6.0.3.1"

gem "bootsnap", ">= 1.4.2", require: false
gem "knock"
gem "raddocs"
gem "rack-cors"
gem "interactor"
gem "decent_exposure"
gem "active_model_serializers"
gem "responders"

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "byebug"
  gem "dotenv-rails"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "letter_opener"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rspec-rails"
  gem "rspec_api_documentation", git: "https://github.com/premiumparking/rspec_api_documentation.git"
end
