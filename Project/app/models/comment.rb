class Comment < ApplicationRecord
  belongs_to :user

  validates :like, inclusion: { in: [true, false] }
end
