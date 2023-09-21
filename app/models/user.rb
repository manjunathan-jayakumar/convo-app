class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :all_except, ->(user) { where.not(id: user)}
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :rooms, through: :participants
end
