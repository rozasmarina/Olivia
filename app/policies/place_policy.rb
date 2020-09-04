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

  def add_review?
    record.owner != user && user
  end

  private

  def is_owner?
    record.owner == user
  end
end
