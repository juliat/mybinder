class DetailedActivity < ActiveRecord::Base
    attr_accessible :activity_id, :description, :name, :user_id, :documents_attributes

    # Relationships
    # =================================================================================
    belongs_to :user
    belongs_to :activity
    has_many :documents, :as => :documentable, :dependent => :destroy
    accepts_nested_attributes_for :documents, :allow_destroy => true

    # Scopes
    # =================================================================================
    scope :for_user, lambda{|user_id| where("user_id = ?", user_id)}
end
