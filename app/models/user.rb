class User < ApplicationRecord
  include Gravtastic
  is_gravtastic :size => 100

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :sent_friend_requests,
           class_name: 'FriendRequest',
           foreign_key: "sender_id",
           dependent: :destroy

  has_many :received_friend_requests,
           class_name: 'FriendRequest',
           foreign_key: "receiver_id",
           dependent: :destroy

  has_many :friend_ships, dependent: :destroy
  has_many :friends, through: :friend_ships, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
