class PlacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    is_owner?
  end

  def update?
    is_owner?
  end

  private

  def is_owner?
    record.user == user
  end
end
