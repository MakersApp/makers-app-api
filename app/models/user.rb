class User < ActiveRecord::Base
  has_many :visits
end
