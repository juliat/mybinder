class OnlineResource < ActiveRecord::Base
    attr_accessible :description, :name, :url, :user_id
  
    # Relationships
    # =================================================================================
    belongs_to :resourceable, :polymorphic => true
    belongs_to :user
end
