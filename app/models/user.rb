class User < ApplicationRecord
  include Gravtastic
  is_gravtastic :size => 100

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :avatar

  has_many :sent_friend_requests,
           class_name: 'FriendRequest',
           foreign_key: "sender_id",
           dependent: :destroy

  has_many :received_friend_requests,
           class_name: 'FriendRequest',
           foreign_key: "receiver_id",
           dependent: :destroy

  has_many :friend_ships,
    ->(user) { FriendShipsQuery.both_ways(user_id: user.id) },
    inverse_of: :user,
    dependent: :destroy

  has_many :friends,
    ->(user) { UsersQuery.friends(user_id: user.id, scope: true) },
    through: :friend_ships,
    dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  def self.from_omniauth(auth)
    oauth_user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
end
