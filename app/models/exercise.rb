class Exercise < ActiveRecord::Base
  attr_accessible :content, :pullup_type_id, :reps, :date
  belongs_to :user
  validates :user_id, presence: true
  #validates :pullup_type_id, presence: true
  #validates :date, presence: true
  #validates :reps, value: { minimum: 1 }
  validates :content, presence: true, length: { maximum: 140 }
  default_scope order: 'exercises.created_at DESC'
end
