class MessagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @messages = @messages.includes(:user, :chat)
  end

  def show
  end

  def new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
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

  def message_params
    params.require(:message).permit(:chat_id, :body)
  end

  def message_params_for_update
    params.require(:message).permit(:body)
  end
end
