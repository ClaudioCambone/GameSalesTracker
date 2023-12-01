class Game < ApplicationRecord
    include Visible
    has_many :game_collections
    has_many :collections, through: :game_collections

    validates :plain, uniqueness: true
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}

    def available_collections(user)
        user.collections.where.not(id: self.collection_ids)
    end
end
