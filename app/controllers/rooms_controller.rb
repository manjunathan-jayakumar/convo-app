class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all_except(current_user)
    rooms = current_user.rooms
    @user_names = rooms.map { |room| room.users.where.not(id: current_user.id).first }
  end
end
