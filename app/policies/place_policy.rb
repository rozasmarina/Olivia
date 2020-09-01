class PlacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
  end
end
