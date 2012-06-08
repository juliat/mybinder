class OnlineResource < ActiveRecord::Base
    attr_accessible :description, :name, :url, :user_id, :resourceable_type, :resourceable_id
  
    # Relationships
    # =================================================================================
    belongs_to :resourceable, :polymorphic => true
    belongs_to :user
    
    # Scopes
    # =================================================================================
    scope :for_user, lambda{|user_id| where("user_id = ?", user_id)}
end
