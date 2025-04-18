class ChatsController < ApplicationController
    def index
      @chats = Chat.all.includes(:sender, :receiver)
    end
  
    def show
      @chat = Chat.find(params[:id])
    end
  end