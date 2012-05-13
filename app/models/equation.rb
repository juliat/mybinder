class Equation < ActiveRecord::Base
    attr_accessible :image_file, :latex, :mod_id

    mount_uploader :image_file, ImageFileUploader
  
    # Relationships
    # =================================================================================
    belongs_to :mod
end
