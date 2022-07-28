class FriendShip < ApplicationRecord
  validates :friend, presence: true, uniqueness: {scope: :user}
  validate :not_self

  belongs_to :user
  belongs_to :friend, class_name: "User"

  private

  def not_self
    errors.add(:friend, "cannot be the same as user") if user == friend
  end
end
