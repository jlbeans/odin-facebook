class FriendShip < ApplicationRecord
  validates :user_id, uniqueness: { scope: :friend_id}
  validate :not_self
  validate :not_duplicate

  belongs_to :user
  belongs_to :friend, class_name: "User"

  private

  def not_self
    return if user != friend
    errors.add(:base, message: "Cannot be a self-referential friendship")
  end

  def not_duplicate
    if FriendShip.exists?(user_id: friend_id, friend_id: user_id)
      errors.add(:base, message: 'This friendship already exists')
    end
  end
end
