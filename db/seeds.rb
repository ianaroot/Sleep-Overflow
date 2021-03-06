# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times { User.create( username: Faker::Name.name, email: Faker::Internet.email, password: "password" ) }

30.times { Question.create( title: "#{Faker::Lorem.sentence}?", content: "#{Faker::Lorem.paragraph}?", user_id: rand(1..10) ) }

90.times { Answer.create( content: Faker::Lorem.paragraph, user_id: rand(1..10), question_id: rand(1..30) ) }

commentable_type = ["Question", "Answer"]
commentable_id = [1..30, 1..90]

120.times do 
  com = rand(2) 
  Comment.create( user_id: rand(1..10), content: Faker::Lorem.sentence, commentable_id: rand( commentable_id[com] ), commentable_type: commentable_type[com]  )
end

10.times do |id|
  votable_type = ["Question", "Answer"]
  votable_id = [[*1..30], [*1..90]]
  user = User.find(id + 1)
  90.times do
    vote_type = rand(2)
    vote = user.votes.build(votable_id: votable_id[vote_type].shuffle!.pop, votable_type: votable_type[vote_type], up_down: [true, false].sample)
    vote.save
  end
end

# 30.times do |id|
#   Question.find(id + 1).answers.shuffle.pop.is_best_answer = true
# end
