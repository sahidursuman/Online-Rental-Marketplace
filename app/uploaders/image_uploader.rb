class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file
  process :convert => 'png'
  process :watermark

  version :thumb do
  	process :resize_to_limit => [242,200]
  end

  version :index do
  	process :resize_to_fit => [555, 555]
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def watermark
  	manipulate! do |img|
  		logo = Magick::Image.read("#{Rails.root}/app/assets/images/small-logo.png").first
  		img = img.composite(logo, Magick::SouthEastGravity, 3, 3, Magick::OverCompositeOp)
  	end
  end
end