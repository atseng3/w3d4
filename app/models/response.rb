class Response < ActiveRecord::Base
  attr_accessible :answer_choice_id, :responder_id
  validates :answer_choice_id, :responder_id, :presence => true

  belongs_to :answer_choice, :primary_key => :id,
             :foreign_key => :answer_choice_id, :class_name => "AnswerChoice"

  belongs_to :respondent, :primary_key => :id,
             :foreign_key => :responder_id, :class_name => "User"
end
