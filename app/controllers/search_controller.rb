class SearchController < ApplicationController
  before_action :authenticate_user!
  def index
    @query = User.ransack(params[:q])
    users = @query.result(distinct: true)
    @people = users.map { |user| { 'record' => user }.merge(get_stats(user, current_user)) } if users.present?
  end

  private

  def get_stats(user1, user2)
    user = [user1, user2].sort
    room_name = "private_#{user[0].id}_#{user[1].id}"
    room = Room.find_by(name: room_name)

    if user1 == user2 || room.nil?
      { 'sent' => 0, 'received' => 0 }
    else
      { 'received' => room.messages.where(user_id: user1).count, 'sent' => room.messages.where(user_id: user2).count }
    end
  end
end
