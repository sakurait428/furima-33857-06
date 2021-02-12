class Item < ApplicationRecord
  belongs_to :user
  has_one_ attached :image
end
