class Place < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: "User", optional: true
  has_many :reviews
  has_many_attached :photos

  validates :name, :latitude, :longitude, presence: true
  validates :latitude, uniqueness: { scope: :longitude,
                                     message: "Este local já existe na base de dados" }
end
