CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.staging?
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: Rails.application.credentials.aws[:region]
    }
    config.fog_directory = Rails.application.credentials.aws[:prod][:bucket]
    config.storage = :fog
  elsif Rails.env.test?
    config.root = Rails.root.join("public")
    config.storage = :file
    config.cache_dir = "testing/carrierwave"
    config.store_dir = "testing/uploads"
    config.enable_processing = false
  else
    config.root = Rails.root.join("public")
    config.storage = :file
    config.cache_dir = "carrierwave"
    config.store_dir = "uploads"
  end
end
