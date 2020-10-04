source "https://rubygems.org"

ruby "2.7.0"

gem "pg"
gem "puma"
gem "rails", "6.0.3.1"

gem "active_model_serializers"
gem "administrate", git: "https://github.com/thoughtbot/administrate.git", ref: "34686446c" # Cause https://github.com/thoughtbot/administrate/issues/1643
gem "administrate-field-carrierwave", "~> 0.5.0"
gem "aws-sdk-s3", require: false
gem "bootsnap", require: false
gem "carrierwave"
gem "decent_exposure"
gem "enumerize"
gem "fog-aws"
gem "image_processing"
gem "interactor"
gem "knock"
gem "mini_magick"
gem "rack-cors"
gem "raddocs"
gem "rails-i18n", "~> 6.0.0" # For 6.0.0 or higher
gem "responders"
gem "rollbar"

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
  gem "bullet"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rspec-rails"
  gem "rspec_api_documentation", git: "https://github.com/premiumparking/rspec_api_documentation.git"
end
