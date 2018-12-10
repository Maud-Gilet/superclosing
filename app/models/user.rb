class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :roles
  has_many :companies, through: :roles
  has_many :investments
  has_many :operations, through: :investments
  has_many :d_documents

  validates :email, presence: true, uniqueness: true

  after_create :send_welcome_email

  mount_uploader :photo_url, PhotoUploader

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now unless invitation_created_at
  end
end
