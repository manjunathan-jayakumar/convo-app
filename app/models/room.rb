class Room < ApplicationRecord
  validates_uniqueness_of :name
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  def self.create_private_room(users, room_name)
    chat_room = Room.create(name: room_name)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: chat_room.id)
    end
    chat_room
  end
end
