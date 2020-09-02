class ResponsePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    record.review.place.owner == user || record.user == user
  end
end
