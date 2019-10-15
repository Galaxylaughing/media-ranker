class User < ApplicationRecord
  has_many :votes
  
  # validations
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :date_joined, presence: true
end
