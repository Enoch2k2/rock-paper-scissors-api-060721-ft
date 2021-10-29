class UsersChannel < ApplicationCable::Channel
  def subscribed
    current_user.update(status: "online")
    ActionCable.server.broadcast("users_channel", { type: "connecting" , users: User.logged_in_users })
    stream_from "users_channel"
  end

  def unsubscribed
    current_user.update(status: "offline")
  end
end