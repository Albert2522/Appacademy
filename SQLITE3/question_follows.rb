require_relative 'questions_database'
require_relative 'user'

class QuestionFollows
  attr_accessor :id, :user_id, :question_id

  def self.followers_for_question_id(question_id)
    users = QuestionsDatabase.execute(<<-SQL, question_id: question_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN users ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = :question_id
    SQL
    return nil if users.nil?
    arr_users = [ ]
    users.each do |hash|
      arr_users << User.new(hash)
    end
    arr_users
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.execute(<<-SQL)
      SELECT
        question_id, COUNT(question_id) as cont
      FROM
        question_follows
      GROUP BY question_id
      ORDER BY cont DESC
    SQL
    arr_questions = [ ]
    i = 0
    while i < n
      arr_questions << Questions.find_by_id(questions[i]['question_id'])
      i += 1
    end
    arr_questions
  end

  def self.followers_for_user_id(user_id)
    questions = QuestionsDatabase.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = :user_id
    SQL
    return nil if questions.nil?
    arr_questions = [ ]
    questions.each do |hash|
      arr_questions << Questions.new(hash)
    end
    arr_questions
  end

  def initialize

  end

end
