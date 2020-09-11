class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.id == user.id
  end

  def update_position?
    record.id == user.id
  end

  def send_message?
    record.id == user.id
  end

  def message_angels?
    record.id == user.id
  end

  def message_near_users?
    record.id == user.id
  end

  def message_authorities?
    record.id == user.id
  end

  def update_messages?
    record.id == user.id
  end

  def community?
    true
  end

  def emergency?
    true
  end

  def together?
    true
  end
end
