source "https://rubygems.org"

ruby "2.7.0"

gem "pg"
gem "puma"
gem "rails", "6.0.3.1"

gem "active_model_serializers"
gem "bootsnap", ">= 1.4.2", require: false
gem "decent_exposure"
gem "interactor"
gem "knock"
gem "rack-cors"
gem "raddocs"
gem "responders"

group :development, :test do
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
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
