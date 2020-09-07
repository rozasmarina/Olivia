class Place < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :owner, class_name: "User", optional: true
  has_many :reviews
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :address, presence: true
  # validates :latitude, uniqueness: { scope: :longitude,
  #  message: "Este local já existe na base de dados" }

  validates :user_id, presence: { if: -> { owner_id.blank? } }
  validates :owner_id, presence: { if: -> { user_id.blank? } }
end
