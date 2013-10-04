class User < ActiveRecord::Base
  attr_accessible :user_name
  validates :user_name, :uniqueness => true

  has_many :authored_polls, :primary_key => :id, :foreign_key => :author_id,
           :class_name => "Poll"

  has_many :responses, :primary_key => :id, :foreign_key => :responder_id,
           :class_name => "Response"


   def completed_polls
     Poll.all.each_with_object([]) do |poll, completed|
       all_res = Poll.select("responses.*, COUNT(*) AS responses_count").joins(:questions => { :answer_choices => :responses}).where("responses.responder_id = ? and polls.id = ?", self.id, poll.id)
       all_qs = poll.questions.length
       completed << poll if all_res.last.responses_count == all_qs
     end
   end

   def uncompleted_polls
     completed = self.completed_polls
     Poll.all.each_with_object([]) do |poll, uncompleted|
       uncompleted << poll unless completed.include?(poll)
     end
   end
 end
