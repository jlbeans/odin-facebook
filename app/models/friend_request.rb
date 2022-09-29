class FriendRequest < ApplicationRecord
  validate :not_self
  validate :not_friends, if: -> { sender}
  validate :no_pending_request

  validates :receiver_id, uniqueness: { scope: :sender_id}

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"


  private

  def not_self
    return if sender != receiver
    errors.add(:receiver, message: "Receiver cannot be the same as sender")
  end

  def not_friends
    if sender.friends.any? { |friend| friend.id == receiver.id }
      errors.add(:receiver_id, message: "You are already friends")
    end
  end

  def no_pending_request
    if FriendRequest.exists?(sender_id: receiver_id, receiver_id: sender_id)
      errors.add(:receiver_id, :blank, message: 'There is already a pending request from this user.')
    end
  end
end
