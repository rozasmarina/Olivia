class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    record.place.owner != user && record.user == user
  end

  def create_response?
    user == record.place.owner || user == record.user
  end

  # def create?
  #   true
  # end

  # def edit?
  #   owner?
  # end

  # def update?
  #   owner?
  # end

  # def destroy?
  #   owner?
  # end

  private

  def owner?
    user == record.user
  end
end
