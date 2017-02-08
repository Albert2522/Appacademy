require_relative 'questions_database'

class Reply
  attr_accessor :question_id, :parent_reply_id, :author_id, :body

  def self.find_by_user_id(id)
  replies_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.author_id = :id
  SQL
  replies_data.nil? ? nil : Reply.new(replies_data)
  end

  def self.find_by_id(id)
      replies_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = :id
    SQL
    replies_data.nil? ? nil : Reply.new(replies_data)
  end

  def self.find_child_by_id(id)
      replies_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.parent_reply_id = :id
    SQL
    replies_data.nil? ? nil : Reply.new(replies_data)
  end

  def self.find_by_question_id(id)
    data = QuestionsDatabase.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.question_id = :id
    SQL
    return nil if data.nil?
    arr_objects = [ ]
    data.map do |hash|
        arr_objects << Reply.new(hash)
    end
    arr_objects
  end

  def initialize(hash)
    @id, @question_id, @parent_reply_id, @author_id, @body =
      hash.values_at('id', 'question_id', 'parent_reply_id', 'author_id', 'body')
  end

  def author
    author = User.find_by_id(@author_id)
    "#{author.fname} #{author.lname}"
  end

  def question
    q = Questions.find_by_id(@question_id)
    q.title
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    Reply.find_child_by_id(@id)
  end

end
