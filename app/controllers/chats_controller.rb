class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update] 

  def index
    @chats = Chat.all.includes(:sender, :receiver)
  end
  
  def show
  end
  
  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.sender_id.present? && @chat.receiver_id.present? && @chat.sender_id == @chat.receiver_id
      @chat.errors.add(:receiver_id, "must be different from sender")
      render :new, status: :unprocessable_entity
    elsif @chat.save
      redirect_to chats_path, notice: 'Chat created successfully.'
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def edit
  end

  def update
    @chat.assign_attributes(chat_params_for_update)

    if @chat.sender_id.present? && @chat.receiver_id.present? && @chat.sender_id == @chat.receiver_id
      @chat.errors.add(:receiver_id, "must be different from sender")
      render :edit, status: :unprocessable_entity
    elsif @chat.save
      redirect_to @chat, notice: 'Chat was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end

  def chat_params_for_update
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end
