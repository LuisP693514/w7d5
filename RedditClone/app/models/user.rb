# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    validates :username, :session_token, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 7}, allow_nil: true

    before_validation :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(username, password)
        user = self.find_by(username: username)
        return nil unless user
        user.is_password?(password) ? user : nil
    end
       
    def is_password?(pass)
        pass_obj = BCrypt::Password.new(self.password_digest)
        pass_obj.is_password?(pass)
    end

    def password=(pass)
        self.password_digest = BCrypt::Password.create(pass)
        @password = pass
    end

    def reset_session_token!
        self.session_token = generate_token
        self.save!
        self.session_token
    end

    private

    def generate_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= generate_token
    end

end
