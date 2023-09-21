class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)
    rooms = current_user.rooms
    @user_names = rooms.map{ |room| room.users.where.not(id: current_user.id).first }

    @room = Room.new
    @room_name = get_name(@user, current_user)
    @chat_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

    @message = Message.new
    @messages = @chat_room.messages.order(created_at: :asc)
    render 'rooms/index'
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end
end
