class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  validates :content, presence: true
  validates :content, length: { minimum: 2 }
  validates :content, uniqueness: true
end
