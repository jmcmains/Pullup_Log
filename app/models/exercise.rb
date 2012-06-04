class Exercise < ActiveRecord::Base
  attr_accessible :content, :pullup_type_id, :reps, :date, :bands_used_attributes
  belongs_to :user
  belongs_to :pullup_type
	has_many :bands_used, class_name: "BandUsed", foreign_key: "exercise_id", dependent: :destroy
  has_many :bands, through: :bands_used
  accepts_nested_attributes_for :bands_used

  validates :user_id, presence: true
  validates :pullup_type_id, presence: true
  validates :date, presence: true
  validates :reps, numericality: {greater_than: 0}
  validates :content, presence: true, length: { maximum: 140 }
  default_scope order: 'exercises.created_at DESC'
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end


