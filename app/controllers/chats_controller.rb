class ChatsController < ApplicationController
  def index
    @chats = Chat.all.includes(:sender, :receiver)
  end
  
  def show
    @chat = Chat.find(params[:id])
  end
  

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.sender_id == @chat.receiver_id
      @chat.errors.add(:receiver_id, "Must be different from sender")
      render :new
    elsif @chat.save
      redirect_to chats_path, notice: 'Chat created successfully.'
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end