module FriendShipsQuery
  extend self

  def both_ways(user_id:)
    relation.unscope(where: :user_id)
      .where(user_id: user_id)
      .or(relation.where(friend_id: user_id))
  end

  private

  def relation
    @relation ||= FriendShip.all
  end
end
