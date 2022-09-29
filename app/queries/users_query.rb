module UsersQuery
  extend self

  def friends(user_id:, scope: false)
    query = relation.joins(sql(scope: scope)).where.not(id: user_id)

    query.where(friend_ships: { user_id: user_id })
      .or(query.where(friend_ships: { friend_id: user_id }))
  end

  private

  def relation
    @relation ||= User.all
  end

  def sql(scope: false)
    if scope
      <<~SQL
        OR users.id = friend_ships.user_id
      SQL
    else
      <<~SQL
        INNER JOIN friend_ships
          ON users.id = friend_ships.friend_id
          OR users.id = friend_ships.user_id
      SQL
    end
  end
end
