class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)
    if user.role == "super_user"
        can :manage, :all
    elsif
       user.role == "admin"
       can :manage, [Course, Unit, Topic, Mod, Standard, 
                     AuthorOrg, Goal, GoalType, Misconception, 
                     KeyConcept, KeyTerm, StandardGoalMapping,
                     Activity]
       can [:show, :update, :destroy], User do |a_user|
            user.id == a_user.id
       end
       
    elsif
        user.role == "teacher"
        can :read, [Course, Unit, Topic, Mod]
        can [:read, :create, :update], Activity
        
        can [:show, :update, :destroy], User do |a_user|
            user.id == a_user.id
        end
        can [:show, :update], Teacher do |teacher|
            user.id == teacher.user_id
        end
    else
       can :read, [Course, Unit, Topic, Mod, Activity]
    end



    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
