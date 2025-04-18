class Chat < ApplicationRecord
    validates :sender_id, presence: true
    validates :receiver_id, presence: true
    #I know we don't see these associations in the course yet, but I had to add them to confirm that the data (users, messages, chats) had been uploaded correctly to the database.    
    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
    belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
    has_many :messages, dependent: :destroy
end
