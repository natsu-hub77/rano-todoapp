class Board < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }
  validates :content, presence: true
  validates :content, length: { minimum: 5 }
  validates :content, uniqueness: true

  validate :validate_title_and_content_length

  belongs_to :user
  has_many :tasks, dependent: :destroy


  private
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    errors.add(:content, '10文字以上で作成してください')  unless char_count > 10
  end
end
