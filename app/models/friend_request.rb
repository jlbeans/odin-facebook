class FriendRequest < ApplicationRecord
  validate :not_self
  validate :not_friends

  validates :sender, presence: true
  validates :receiver, presence: true, uniqueness: { scope: :sender}

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  def accept
    receiver.friends << sender
    self.destroy
  end

  def reject
    self.destroy
  end

  private

  def not_self
    errors.add(:receiver, message: "cannot be the same as sender") if sender == receiver
  end

  def not_friends
    errors.add(:receiver, message: "is already a friend!") if  sender.friends.include?(receiver) || receiver.friends.include?(sender)
  end
end
