class Collection < ApplicationRecord
  belongs_to :user
  has_many :game_collections, dependent: :destroy
  has_many :games, through: :game_collections
end
