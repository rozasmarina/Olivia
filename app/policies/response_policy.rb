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
    Review.find(params[:review_id]).place.owner == user
  end
end
