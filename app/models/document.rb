class Document < ActiveRecord::Base
    attr_accessible :description, :file, :name, :description, :user_id

    mount_uploader :file, FileUploader
    
    # Relationships
    # =================================================================================
    belongs_to :documentable, :polymorphic => true
    belongs_to :user
  
end
