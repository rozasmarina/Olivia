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
    user
  end

  def create?
    user
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

  def add_owner?
    user.is_business && record.owner.nil? && user.owned_place.nil?
  end

  private

  def is_owner?
    record.owner == user
  end
end
