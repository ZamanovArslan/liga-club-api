ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)
require "rspec/rails"
require "spec_helper"
require "rspec_api_documentation/dsl"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }
