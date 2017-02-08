require_relative 'questions_database'
require_relative 'questions'

class User
  attr_accessor :fname, :lname, :id

  def self.find_by_id(id)
    user_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
      SELECT
        users.*
      FROM
        users
      WHERE
        users.id = :id

    SQL
    user_data.nil? ? nil : User.new(user_data)
  end

  def self.find_by_name(fname, lname)
    user_data = QuestionsDatabase.get_first_row(<<-SQL, fname: fname, lname: lname)
      SELECT
        users.*
      FROM
        users
      WHERE
        users.fname = :fname and users.lname = :lname
    SQL

    user_data.nil? ? nil : User.new(user_data)
  end

  def initialize(hash)
    @id = hash['id']
    @fname = hash['fname']
    @lname = hash['lname']
  end

  def authored_questions
    Questions.find_by_author_id(@id)
  end

  def authored_replies
      Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollows.followers_for_user_id(@id)
  end
end
