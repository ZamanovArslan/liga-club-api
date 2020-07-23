ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)
require "spec_helper"
require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.after(:suite) do
    FileUtils.rm_rf(Dir[Rails.root.join("public", "testing")])
  end
end
