defmodule Elixirbot.Bot do
  @moduledoc false
  def verify_webhook(params) do
    facebook_chat_bot = Application.get_env(:elixirbot,:facebook_chat_bot)
    mode = params["hub.mode"]
    token = params["hub.verify_token"]
    mode == "subscribe" && token == facebook_chat_bot.webhook_verify_token
    end
end
