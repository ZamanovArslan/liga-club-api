namespace :app do
  desc "Update api docs"
  task docs: :environment do
    sh "rspec --format RspecApiDocumentation::ApiFormatter"
  end
end
