# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

user1 = User.create(user_name: 'Albert')
user2 = User.create(user_name: 'Joshua')

poll = Poll.create(title: 'New_poll', author_id: user1.id)

question1 = Question.create(text: 'What is your favorite color?', poll_id: poll.id)
question2 = Question.create(text: "What's the best coding school", poll_id: poll.id)

answer_choice1 = AnswerChoice.create(text: 'blue',question_id: question1.id)
answer_choice2 = AnswerChoice.create(text: 'red', question_id: question1.id)
answer_choice3 = AnswerChoice.create(text: 'AppAcademy', question_id: question2.id)
answer_choice4 = AnswerChoice.create(text: 'HackReactor', question_id: question2.id)

response1 = Response.create(answer_choice_id: answer_choice2.id, respondent_id: user2.id)
response1 = Response.create(answer_choice_id: answer_choice4.id, respondent_id: user2.id)
