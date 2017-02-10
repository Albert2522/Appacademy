# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true  

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: :Response

  has_many :answers,
    through: :responses,
    source: :answer_choice

  has_many :answered_questions,
    through: :answers,
    source: :question

  has_many :authored_questions,
    through: :authored_polls,
    source: :questions

  has_many :authored_answer_choices,
    through: :authored_questions,
    source: :answer_choices

end
