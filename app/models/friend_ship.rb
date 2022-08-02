class FriendShip < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: {scope: :user}
  validate :not_self

  belongs_to :user
  belongs_to :friend, class_name: "User"

  private

  def not_self
    errors.add(:friend, "cannot be the same as user") if user == friend
  end

  def create_inverse_relationship
    friend.friend_ships.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friend_ships.find_by(friend: user)
    friendship.destroy if friendship
  end
end
