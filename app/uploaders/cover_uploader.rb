require 'carrierwave/processing/mime_types'

class CoverUploader < BaseUploader
  # Include RMagick or MiniMagick support:
  include CarrierWave::MimeTypes
  include CarrierWave::MiniMagick

  # process :set_content_type
  # process :save_size_and_mime_type_in_model

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/images/#{base_store_dir}/#{model.id}"
  end

  # Process files as they are uploaded:
  # process :resize_to_fit => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # size: limits in 120x120.
  # version :thumb do
  #   process :resize_to_limit => [120, 120]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
   # "#{secure_token}.#{file.extension}" if original_filename.present?
    original_filename if original_filename.present?
  end

  protected

  def save_size_and_mime_type_in_model
    model.mime_type = file.content_type if file.content_type
    model.size = file.size
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
