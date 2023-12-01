class Collection < ApplicationRecord
  belongs_to :user
  has_many :game_collections
  has_many :games, through: :game_collections
end
