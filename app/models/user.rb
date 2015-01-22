class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_api_key
  after_create :send_welcome_email

  has_many :sources

  self.default_scope { includes(:sources).order('created_at ASC') }

  def super_admin?
    self.role == "super"
  end

  def admin?
    self.role == "admin"
  end

  def encrypted_mail_id
    Base64.encode64(self.email)
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def generate_api_key
    self.api_key = UUID.new.generate.gsub("-", "")
  end
end
