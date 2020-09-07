class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.id == user.id
  end

  def edit?
    record.id == user.id
  end

  def update?
    record.id == user.id
  end
end
