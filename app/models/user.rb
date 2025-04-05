class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy

  def has_written?(board)
    boards.exists?(id: board.id)
  end

  def has_written_task?(task)
    tasks.exists?(id: task.id)
  end
end
