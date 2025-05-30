class ChatsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @chats = @chats.includes(:sender, :receiver)
  end

  def show
  end

  def new
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.sender = current_user
    if @chat.receiver_id.present? && @chat.sender_id == @chat.receiver_id
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
    @chat.assign_attributes(chat_params)
    if @chat.receiver_id.present? && @chat.sender_id == @chat.receiver_id
      @chat.errors.add(:receiver_id, "must be different from sender")
      render :edit, status: :unprocessable_entity
    elsif @chat.save
      redirect_to @chat, notice: 'Chat was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end
