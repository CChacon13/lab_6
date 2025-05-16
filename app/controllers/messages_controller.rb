class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update]

  def index
    @messages = Message.all.includes(:user, :chat)
  end
  
  def show
  end
  
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to messages_path, notice: 'Message created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @message.update(message_params_for_update)
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end

  def message_params_for_update
    params.require(:message).permit(:body)
  end
end
