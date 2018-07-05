# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Comment.delete_all
Post.delete_all

50.times do
  p = Post.create(
    title: Faker::Hacker.say_something_smart,
    body: Faker::HarryPotter.quote,
  )

  if p.valid?
    rand(0..10).times do
      Comment.create(
        body: Faker::Matz.quote,
        post: p
      )
    end
  end
end

posts = Post.all
comments = Comment.all

puts Cowsay.say("Created #{posts.count} posts", :frogs)
puts Cowsay.say("Created #{comments.count} comments", :sheep)