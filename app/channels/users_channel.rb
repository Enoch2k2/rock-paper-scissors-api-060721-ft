class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_channel"
  end

  def receive(data)
    user = User.find_by_id(data["user_id"])
    user.update(status: "online")
    ActionCable.server.broadcast("users_channel", { users: User.logged_in_users })
  end

  def unsubscribed
  end
  
  def offline(data)
    user = User.find_by_id(data["user_id"])
    user.update(status: "offline")
    ActionCable.server.broadcast("users_channel", { users: User.logged_in_users })
    stop_stream_from "users_channel"
  end
end