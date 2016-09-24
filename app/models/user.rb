# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string
#  email         :string
#  password_hash :string
#  password_salt :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_name     :string
#  api_key       :string
#

class User < ActiveRecord::Base
  #attr_accessible :user_name, :name, :email, :password, :password_confirmation
  has_many :reports, :dependent => :destroy
  has_one :dash_board
  attr_accessor :password
  before_save :encrypt_password
  before_save :check_and_generate_api_key
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_confirmation_of :password
  validates :password, :presence => true, :confirmation => true,
            :length => { :within => 6..40 }

  validates :email, :presence => true, :format   => { :with => email_regex }
  validates :user_name, :presence => true, :uniqueness => true
  
  def self.authenticate(user_name, password)
    user = find_by_user_name(user_name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && (user.password_salt == cookie_salt)) ? user : nil #operateur ternaire idem C
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def check_and_generate_api_key
    if ((admin? == true) && (api_key == nil)) then
      generate_api_key
    end      
  end
  
  def generate_api_key
    self.api_key = SecureRandom.hex
  end
  
  def admin?
    if user_name == 'admin' then
      return true
    end
    return false
  end
  
end
