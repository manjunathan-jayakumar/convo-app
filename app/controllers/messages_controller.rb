class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @message = current_user.messages.create(context: msg_params[:context], room_id: params[:room_id])
  end
  private
  def msg_params
    params.require(:message).permit(:context)
  end
end
