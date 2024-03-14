class GameCollection < ApplicationRecord
  belongs_to :collection

  validates :game_id, presence: true, uniqueness: { scope: :collection_id }
end
