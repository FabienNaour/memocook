class PhotoUploader < CarrierWave::Uploader::Base
   include Cloudinary::CarrierWave


  def public_id
    "#{model.class.to_s.underscore}-#{mounted_as}-#{model.id}"
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end


# Calling 'process' outside of a version block causes the image to be
  # processed before it's stored. As a result, subsequent requests
  # for versions will use a pre-composited image.
  # process :generate_on_upload

  version :thumb do
    process :eager => true
    # process :resize_to_fill => [250, 250]
  end

  # Returns a group of Cloudinary transformations which will be applied
  # in order when the image is uploaded
  def generate_on_upload
    {
      transformation: [
        resize_base_image
      ]
    }
  end

  private
  def resize_base_image
    { crop: 'scale', width: 1024, height: 768 }
  end

end

