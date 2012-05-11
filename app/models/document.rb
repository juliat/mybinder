class Document < ActiveRecord::Base
  attr_accessible :description, :file
 
  belongs_to :documentable, :polymorphic => true
  
  mount_uploader :file, FileUploader
end
