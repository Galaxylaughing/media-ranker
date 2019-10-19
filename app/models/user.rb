class User < ApplicationRecord
  has_many :votes
  
  # validations
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { in: 1..30 }
  validates :date_joined, presence: true
  
  def self.sort_by_date_joined()
    # https://stackoverflow.com/questions/3587776/ruby-on-rails-how-do-i-sort-with-two-columns-using-activerecord (for using multiple order parameters)
    return User.order(date_joined: :asc, username: :asc)
  end
  
  def self.find_votes_by_id(id)
    user = User.find_by(id: id)
    if user
      user_votes = user.votes
      return user_votes
    else
      return []
    end
  end
end
