namespace :app do
  desc "Update api docs"
  task docs: :environment do
    sh "bin/rspec --format RspecApiDocumentation::ApiFormatter"
  end
end
