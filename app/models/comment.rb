class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :task
  validates :content, presence: true
end
