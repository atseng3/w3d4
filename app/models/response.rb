class Response < ActiveRecord::Base
  attr_accessible :answer_choice_id, :responder_id
  validates :answer_choice_id, :responder_id, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_poll

  belongs_to :answer_choice, :primary_key => :id,
             :foreign_key => :answer_choice_id, :class_name => "AnswerChoice"

  belongs_to :respondent, :primary_key => :id,
             :foreign_key => :responder_id, :class_name => "User"

  private

  def author_cant_respond_to_poll
    unless User.select("answer_choices.*").joins(:authored_polls => { :questions => :answer_choices}).where("answer_choices.id = ? AND users.id = ?", answer_choice_id, responder_id).empty?
      errors[:base] << "Can't answer your own question."
    end
  end

  def respondent_has_not_already_answered_question
    responses = existing_responses
    unless responses.empty? || (responses.count == 1 && responses[0].id == id)
      errors[:responder_id] << "can't answer same question twice"
    end
  end

  def existing_responses
    question_id =  answer_choice.question_id

    Response.find_by_sql [<<-SQL, question_id, self.responder_id]
    SELECT
      r.*
    FROM
      answer_choices a
    JOIN
      responses r
    ON a.id = r.answer_choice_id
    WHERE a.question_id = ? AND r.responder_id = ?
    SQL
  end
end