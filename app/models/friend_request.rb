class FriendRequest < ApplicationRecord
  validate :not_self
  validate :not_friends, if: -> { sender}
  validate :no_pending_request

  validates :receiver_id, uniqueness: { scope: :sender_id}

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
    if sender.friends.any? { |friend| friend.id == receiver.id }
      errors.add(:receiver_id, :blank, message: "already friends")
    end
  end

  def no_pending_request
    if FriendRequest.exists?(sender_id: receiver_id, receiver_id: sender_id)
      errors.add(:receiver_id, :blank, message: 'There is already a pending request from this user.')
    end
  end
end
