class Document < ActiveRecord::Base
    attr_accessible :description, :file, :name, :description, :user_id

    belongs_to :documentable, :polymorphic => true

    mount_uploader :file, FileUploader
    
    # Relationships
    # =================================================================================
    belongs_to :user
  
end
