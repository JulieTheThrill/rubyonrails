class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :u_number, presence: true, uniqueness: true
  validates_presence_of :password, :on => :create

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

end