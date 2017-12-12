# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# users
10.times do |n|
  email = Faker::Internet.unique.email
  name = email.split("@")[0]
  password = "password"
  uid = User.create_unique_string
  user = User.new(
          email: email,
          name: name,
          password: password,
          password_confirmation: password,
          uid: uid,
  )
  user.skip_confirmation!
  user.save!
end

user1 = User.first
user2 = User.find(2)

# topics
3.times do |n|
  topic = user1.topics.build(content: "サンプルの投稿内容です。#{n+1}個目の投稿になります。")
  topic.save!
end

# comments
topic = Topic.first
comment = topic.comments.build(user_id: user2.id, content: "サンプルコメントだよ。")
comment.save!

# relationships
user1.follow!(user2)
user2.follow!(user1)

# messages
conversation = Conversation.create!(sender_id: user1.id, recipient_id: user2.id)
message1 = conversation.messages.build(body: "サンプルメッセージ", user_id: user1.id)
message2 = conversation.messages.build(body: "サンプル返答", user_id: user2.id)

message1.save!
message2.save!
