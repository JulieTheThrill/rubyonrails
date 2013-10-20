class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :u_number, presence: true, uniqueness: true
  validates_presence_of :password, :on => :create

  has_many :survey_responses
  has_many :survey_questions, through: :survey_responses

  has_secure_password

  def self.authenticate(username_or_email = "", login_password = "")
    if EMAIL_REGEX.match(username_or_email)
      user = User.find_by(email: username_or_email).try(:authenticate, login_password)
    else
      user = User.find_by(username: username_or_email).try(:authenticate, login_password)
    end
    if user
      return user
    else
      return false
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    ModelMailer.forgot_password(self).deliver
  end

  private
  def generate_token(column)
    begin
      self[column] = SecureRandom.hex[0,10].upcase
    end while self.class.exists?(column => self[column])
  end

end