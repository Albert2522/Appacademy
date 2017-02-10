class Response < ActiveRecord::Base
  validates :answer_choice_id, :respondent_id, presence: true
  validate :not_duplicate_response
  validate :cant_respond_to_own_poll

  def cant_respond_to_own_poll
    a = AnswerChoice.find_by(id: answer_choice_id)
    a = a.question.poll.author
    if a.id == respondent_id
      errors[:author] << 'cant respond to his own poll'
    end
  end

  def not_duplicate_response
    a = sibling_responses.where.not('responses.id = ?', self.id)
    if a.exists?(respondent_id: self.respondent_id)
      errors[:duplicate] << 'not allowed'
    end
  end

  has_one :poll_author,
    through: :poll,
    source: :author

  has_one :poll,
    through: :question,
    source: :poll

  has_many :sibling_responses,
    through: :question,
    source: :responses

  has_one :question,
    through: :answer_choice,
    source: :question

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: :User
end
