class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me, :role
    # attr_accessible :title, :body
    
    # Validations (beyond devise's)
    # =================================================================================
    validates_inclusion_of :role, :in => %w[admin teacher contributor], :message => "is not an option"
    
    
    # Relationships
    # =================================================================================
    # user may have associated teacher account
    has_one :teacher
    
    
    # Constants
    # ==========
    # there's actually one more role -- super_user, but users can't register as one
    ROLES_LIST = [['Administrator', 'admin'],['Teacher', 'teacher'],['Contributor', 'contributor']]
    
end
