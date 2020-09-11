class Review < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_many :responses, dependent: :destroy

  after_commit :create_notification, on: :create

  validates :title, :content, :rating, presence: { message: "Campo obrigatório" }
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: (0..5).to_a }

  private

  def create_notification
    Notification.create do |notification|
      notification.notify_type = 'review'
      notification.actor = user
      notification.user = place.owner
      notification.target = self
      notification.second_target = place
    end
  end
end
