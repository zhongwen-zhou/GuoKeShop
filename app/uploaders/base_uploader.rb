class BaseUploader < CarrierWave::Uploader::Base
  storage :file
  after :remove, :delete_empty_dir

  delegate :delete, :basename, :size, :to => :file
  

  def base_store_dir
    string_id = model.id.to_s
    "#{string_id[0, 2]}/#{string_id[2, 2]}"
  end

  def delete_empty_dir
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end
end