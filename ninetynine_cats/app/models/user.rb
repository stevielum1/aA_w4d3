# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  attr_reader :password
  
  validates :user_name, :session_token, :password_digest, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  def self.find_by_credentials(user_name, pw)
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    user.is_password?(pw) ? user : nil
  end
  
  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end
  
  def generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
end
