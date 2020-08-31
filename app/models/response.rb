class Response < ApplicationRecord
  belongs_to :review
  belongs_to :owner, class_name: "User", through: :places
  validates :response, presence: { message: "Campo obrigatório" }
end
