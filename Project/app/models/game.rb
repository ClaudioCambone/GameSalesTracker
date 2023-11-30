class Game < ApplicationRecord
    include Visible
    has_and_belongs_to_many :collections

    
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}

    def available_collections(user)
        user.collections.where.not(id: self.collection_ids)
    end
end
