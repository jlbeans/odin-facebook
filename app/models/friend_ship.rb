class FriendShip < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  validates :user_id, uniqueness: { scope: :friend_id}
  validate :not_self
  validate :not_duplicate

  belongs_to :user
  belongs_to :friend, class_name: "User"

  private

  def not_self
    errors.add(:friend, "cannot be the same as user") if user == friend
  end

  def not_duplicate
    if FriendShip.exists?(user_id: friend_id, friend_id: user_id)
      errors.add(:base, :blank, message: 'This friendship already exists')
    end
  end

  def create_inverse_relationship
    friend.friend_ships.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friend_ships.find_by(friend: user)
    friendship.destroy if friendship
  end
end
