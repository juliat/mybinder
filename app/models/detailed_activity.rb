class DetailedActivity < ActiveRecord::Base
    attr_accessible :activity_id, :description, :name, :user_id, :documents_attributes

    # Relationships
    # =================================================================================
    belongs_to :user
    belongs_to :activity
    has_many :documents, :as => :documentable, :dependent => :destroy
    accepts_nested_attributes_for :documents, :allow_destroy => true

    #~ has_many :online_resources, :as => :resourceable, :dependent => :destroy
    #~ accepts_nested_attributes_for :online_resources, :allow_destroy => true
end
