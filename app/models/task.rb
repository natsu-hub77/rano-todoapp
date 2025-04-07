class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_one_attached :eyecatch

  has_many :comments, dependent: :destroy
  
  belongs_to :user
  belongs_to :board

end
