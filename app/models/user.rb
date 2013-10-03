class User < ActiveRecord::Base
  attr_accessible :user_name
  validates :user_name, :uniqueness => true

  has_many :authored_polls, :primary_key => :id, :foreign_key => :author_id,
           :class_name => "Poll"

  has_many :responses, :primary_key => :id, :foreign_key => :responder_id,
           :class_name => "Response"
end
