class Page < ActiveRecord::Base
  has_many :takers
  has_many :users, :through => :takers
  has_many :submissions
  has_many :questions
end
