class User < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {in: 6..20}, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!
    @user = User.find_by_email(email)

    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
