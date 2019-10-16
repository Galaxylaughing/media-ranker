class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  # _should_ make sure all usr-work combinations must be unique
  validates_uniqueness_of :user_id, scope: :work_id
end
