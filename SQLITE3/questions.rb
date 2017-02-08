require_relative 'questions_database'

class Questions
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    question_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = :id
    SQL
    question_data.nil? ? nil : Questions.new(question_data)
  end

  def self.find_by_author_id(id)
    question_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.author_id = :id
    SQL

    question_data.nil? ? nil : Questions.new(question_data)
  end

  def initialize(hash)
    @id, @title, @body, @author_id =
      hash.values_at('id', 'title', 'body', 'author_id')
  end

  def author
    author = User.find_by_id(@author_id)
    "#{author.fname} #{author.lname}"
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollows.followers_for_question_id(@id)
  end
end
