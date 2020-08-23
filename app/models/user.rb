require 'open-uri'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]
  has_many :video_items
  acts_as_voter
  has_many :comments
  has_one_attached :avatar


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name  
      if auth.info.image.present?
        avatar = open(auth.info.image)
        user.avatar.attach(io: avatar  , filename: "#{user.created_at.to_s}.jpg")
      end
      # user.skip_confirmation!
    end
  end

end
