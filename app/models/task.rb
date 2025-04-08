class Task < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :content, presence: true
  validates :content, length: { minimum: 5 }
  validates :content, uniqueness: true
  
  has_one_attached :eyecatch

  has_many :comments, dependent: :destroy
  
  belongs_to :user
  belongs_to :board

end
