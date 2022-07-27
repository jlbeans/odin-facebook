class FriendRequest < ApplicationRecord

  validate :not_self
  validate :not_friends

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  def accept
    sender.friends << receiver
    receiver.friends << sender
    self.destroy
  end

  def reject
    self.destroy
  end

  def not_self
    errors.add(:base, message: "sender cannot be the same as receiver") if sender == receiver
  end

  def not_friends
    errors.add(:base, message: "you're already friends!") if sender.friends.include?(receiver)
  end

end
