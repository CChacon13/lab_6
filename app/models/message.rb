class Message < ApplicationRecord
    validates :chat_id, presence: true
    validates :user_id, presence: true
    validates :body, presence: true
    #read the comment position in "chat.rb"
    belongs_to :chat
    belongs_to :user
end
