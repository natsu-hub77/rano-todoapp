# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  content    :text
#  deadline   :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
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
