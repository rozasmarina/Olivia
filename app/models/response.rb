class Response < ApplicationRecord
  belongs_to :review
  validates :response, presence: { message: "Campo obrigatório" }
end
