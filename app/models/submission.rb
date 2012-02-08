class Submission < ActiveRecord::Base
  belongs_to :group
  belongs_to :question
  belongs_to :user
end
