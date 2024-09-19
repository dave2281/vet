class UserPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin? || record == user
  end

  def show?
    user.admin? || record == user
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
