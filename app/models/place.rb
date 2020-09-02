class Place < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: "User", optional: true
  has_many :reviews
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :address, presence: true
  # validates :latitude, uniqueness: { scope: :longitude,
  #  message: "Este local já existe na base de dados" }
end
