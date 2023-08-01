class Comment < ApplicationRecord
  include Visible
  
  belongs_to :game
end
