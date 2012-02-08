class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers
  has_one :answer
  has_many :groups
end
