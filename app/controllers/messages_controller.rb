class MessagesController < ApplicationController
    def index
      @messages = Message.all.includes(:user, :chat)
    end
  
    def show
      @message = Message.find(params[:id])
    end
  end