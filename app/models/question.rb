class Question < ActiveRecord::Base
  attr_accessible :text, :poll_id
  validates :text, :poll_id, :presence => true

  belongs_to :poll, :primary_key => :id, :foreign_key => :poll_id,
             :class_name => "Poll"

  has_many :answer_choices, :primary_key => :id, :foreign_key => :question_id,
           :class_name => "AnswerChoice", :dependent => :destroy

   def results
     answer_choices = self.answer_choices.includes(:responses)

     answer_choices.each_with_object({}) do |answer, answer_responses_counts|
       answer_responses_counts[answer.text] = answer.responses.length
     end
   end
end