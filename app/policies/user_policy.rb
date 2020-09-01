class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    is_user?
  end
  
  def new?
    true
  end

  def create?
    true
  end

  def edit?
    is_user?
  end

  def update?
    is_user?
  end

  def destroy?
    is_user?
  end

  private

  def is_user?
    record.user == user
  end
end
