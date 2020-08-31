class Response < ApplicationRecord
  belongs_to :review
  belongs_to :user
  validates :response, presence: { message: "Campo obrigatório" }
end
