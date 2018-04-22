class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    #validates :name, presence: true, uniqueness: true
    #has_secure_password
    
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    #validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    #has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    
    # Returns true if the given token matches the digest.
  #def authenticated?(remember_token)
  #  BCrypt::Password.new(remember_digest).is_password?(remember_token)
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
    
end

    #after_destroy :ensure_an_admin_remains

#class Error < StandardError
#end

#private
#def ensure_an_admin_remains
#    if User.count.zero?
#        raise Error.new "Can't delete last user"
#    end
#end
