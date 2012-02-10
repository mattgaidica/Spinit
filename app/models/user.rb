class User < ActiveRecord::Base
  has_one :position
  has_many :submissions
  has_many :takers
  has_many :pages, :through => :takers
  has_many :messages
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.image = auth["info"]["image"]
    end
  end
end
