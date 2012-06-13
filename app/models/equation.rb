class Equation < ActiveRecord::Base
    attr_accessible :image_file, :latex, :number, :mod_id, :remote_image_url

    mount_uploader :image_file, ImageUploader
  
    # Relationships
    # =================================================================================
    belongs_to :mod
end
