# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Chat.destroy_all
Message.destroy_all
#users

10.times do |i|
    User.create!(
        email:"usuario#{i+1}@example.com",
        first_name: Faker::Name.first_name,
        last_name:Faker::Name.last_name
    )
end

#chats
user_ids = User.pluck(:id)
10.times do
    sender = user_ids.sample
    receiver = (user_ids - [sender]).sample
    Chat.create!(
        sender_id: sender,
        receiver_id: receiver
    )
end

#messages
chat_ids = Chat.pluck(:id)
30.times do
    Message.create!(
        chat_id: chat_ids.sample,
        user_id:user_ids.sample,
        body: Faker::Lorem.paragraph(sentence_count: 2)
    )
end

puts "Users: #{User.count}"
puts "Chats: #{Chat.count}"
puts "Messages: #{Message.count}"
