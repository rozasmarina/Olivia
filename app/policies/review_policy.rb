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

  def edit?
    owner? && record.created_at >= Time.now - 30.minutes
  end

  def update?
    owner?
  end

  def disable?
    owner? && record.is_disabled == false
  end

  def satisfy?
    owner? && record.responses.present? && !record.is_satisfied
  end

  # def destroy?
  #   owner?
  # end

  private

  def owner?
    user == record.user
  end
end
