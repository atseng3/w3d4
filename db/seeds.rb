# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


pollster_user = User.create!({user_name: "Bob"})
responder_user = User.create!({user_name: "ResponderBill"})

poll = Poll.create!({title: "Test Poll", author_id: pollster_user.id })

question1 = Question.create!({text: "Do you like SQL?", poll_id: poll.id })

answer_a = AnswerChoice.create!({text: "Yes.", question_id: question1.id })
answer_b = AnswerChoice.create!({text: "No.", question_id: question1.id })

response = Response.create!({answer_choice_id: answer_a.id,
                             responder_id: responder_user.id})




