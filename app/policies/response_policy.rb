class ResponsePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    # false
    record.place.owner == user
  end

  def create?
    record.review.place.owner == user
  end
end
