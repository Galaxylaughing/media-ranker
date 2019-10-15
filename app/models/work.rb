class Work < ApplicationRecord
  has_many :votes
  
  # validations
  validates :name, presence: true
  validates :creator, presence: true
  # _should_ make sure all name-creator combinations must be unique
  validates_uniqueness_of :name, scope: :creator
  validates :category, presence: true
  
  def find_highest_voted
  end
end
