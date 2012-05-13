class TextReference < ActiveRecord::Base
    
    attr_accessible :book, :location
    
    # Relationships
    # =================================================================================  
    belongs_to :textbookable, :polymorphic => true
    
    # Constants
    # =================================================================================
    BOOKS_LIST = ['Holt', 'Hewitt']  
end
