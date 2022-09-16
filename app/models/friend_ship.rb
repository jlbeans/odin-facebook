class FriendShip < ApplicationRecord
  validates :user_id, uniqueness: { scope: :friend_id}
  validate :not_self

  belongs_to :user
  belongs_to :friend, class_name: "User"

  private

  def not_self
    return if !user == friend
    errors.add(:friend, "cannot be the same as user")
  end
end 
