class DetailedActivity < ActiveRecord::Base
    attr_accessible :activity_id, :description, :name, :user_id, :documents_attributes

    # Relationships
    # =================================================================================
    belongs_to :user
    has_many :documents, :as => :documentable, :dependent => :destroy
    accepts_nested_attributes_for :documents, :allow_destroy => true

end
