# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  def results
    results = {}
    Question.select('answer_choices.id', 'answer_choices.text', 'responses.respondent_id').joins(:responses)
  end

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses
end
