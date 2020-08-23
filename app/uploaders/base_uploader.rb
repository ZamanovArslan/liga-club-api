class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process resize_to_fit: [1024, 1024]
  end

  version :medium, from_version: :large do
    process resize_to_fit: [512, 512]
  end

  version :thumb, from_version: :medium do
    process resize_to_fit: [360, 360]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  def size_range
    0.megabytes..3.megabyte
  end
end
