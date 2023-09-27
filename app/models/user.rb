class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_destroy :destroy_rooms
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :rooms, through: :participants

  after_create_commit { broadcast_append_to 'users' }

  scope :all_except, ->(user) { where.not(id: user) }

  private

  def destroy_rooms
    rooms.each(&:destroy)
  end

end
