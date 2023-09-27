class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users
  def show
    @room_name = get_name(@user, current_user)
    @chat_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

    @message = Message.new
    @messages = @chat_room.messages.order(created_at: :asc).includes(:user)

    @user_names = set_chats

    render 'rooms/index'
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

  def set_chats
    rooms = current_user.rooms
    rooms.map { |room| room.users.where.not(id: current_user.id).first }
  end

  def set_users
    @user = User.find(params[:id])
    @users = User.all_except(current_user)
  end
end
