class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  
  # validations
  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  # make sure all title-creator-category combinations must be unique
  validates_uniqueness_of :title, scope: [:creator, :category], message: "cannot have the same creator and category as another work"
  
  def self.find_highest_voted 
    # works_list = Work.all
    
    # max = Work.first
    
    # works_list.each do |work|
    #   if work.votes.length > max.votes.length
    #     max = work
    #   end
    # end
    
    # if max.votes.length == 0
    #   return Work.all.sample
    # end
    
    # return max
    
    return Work.sort_by_votes().first
  end
  
  def self.find_top_ten(category)
    # list = Work.where(category: category)
    
    # sorted_list = list.sort { |a, b|
    #   r = (b.votes.length <=> a.votes.length)
    #   if r == 0 && b.publication_date && a.publication_date
    #     r = (b.publication_date <=> a.publication_date)
    #   end
    #   r = (b.id <=> a.id) if (r == 0)
    #   r
    # }
    
    # top_ten = sorted_list[0..9]
    
    # return top_ten
    return Work.where(category: category).sort_by_votes().limit(10)
  end
  
  def self.sort_by_votes()
    # https://stackoverflow.com/questions/16996618/rails-order-by-results-count-of-has-many-association
    # https://github.com/rails/rails/issues/32995 (for how to use Arel.sql)
    # https://stackoverflow.com/questions/3587776/ruby-on-rails-how-do-i-sort-with-two-columns-using-activerecord (for using multiple order parameters)
    return Work.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC'), publication_date: :desc, id: :desc)
  end
  
end
