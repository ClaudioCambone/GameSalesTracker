class GameCollection < ApplicationRecord
  belongs_to :collection

  validates :plain, presence: true, uniqueness: { scope: :collection_id }
end
