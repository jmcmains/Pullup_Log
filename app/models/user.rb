class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
	has_many :exercises, dependent: :destroy
  
  before_save { |user| user.email = email.downcase }
  before_create { generate_token(:remember_token) }
  
  validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true

  def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		self.update_attributes(password_reset_sent_at: Time.zone.now, remember_token: self.password_reset_token)
		UserMailer.password_reset(self).deliver
	end
	
	def feed
		Exercise.where("user_id = ?", id)
	end	
	
	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

end
