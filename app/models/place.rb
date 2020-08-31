class Place < ApplicationRecord
  belongs_to :user
  has_one :owner, class_name: 'User'
end
