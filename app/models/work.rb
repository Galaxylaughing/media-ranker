class Work < ApplicationRecord
  has_many :votes
  
  # validations
  validates :name, presence: true
  validates :creator, presence: true
  # _should_ make sure all name-creator combinations must be unique
  validates_uniqueness_of :name, scope: :creator
  validates :category, presence: true
  
  def self.find_highest_voted 
    works_list = Work.all
    
    max = Work.first
    
    works_list.each do |work|
      if work.votes.length > max.votes.length
        max = work
      end
    end
    
    if max.votes.length == 0
      return nil
    end
    
    return max
  end
  
  def self.find_top_ten(category)
    list = Work.where(category: category)
    
    ascending_list = list.sort_by{ |item| item.votes.length }
    
    descending_list = ascending_list.reverse
    
    top_ten = descending_list[0..9]
    
    return top_ten
  end
end
