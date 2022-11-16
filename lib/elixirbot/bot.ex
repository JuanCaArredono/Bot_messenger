defmodule Elixirbot.Bot do
  import Logger
  @moduledoc false
  def verify_webhook(params) do
    facebook_chat_bot = Application.get_env(:elixirbot,:facebook_chat_bot)
    mode = params["hub.mode"]
    token = params["hub.verify_token"]
    mode == "subscribe" && token == facebook_chat_bot.webhook_verify_token
    end

  def send_message(msg_template) do
    endpoint = bot_endpoint()
    IO.inspect(endpoint)
    headers = ["Content-Type": "application/json"]
    # HTTPoison.post!(url_issue, body_issue, headers, [timeout: 40_000])
    IO.inspect(msg_template)
    case HTTPoison.post("https://graph.facebook.com/v14.0/me/messages?access_token=test", msg_template|>Poison.encode!) do
      {:ok, response} ->
        IO.inspect(inspect(response))
        Logger.info("Message Sent to Bot")
        :ok
      {:error, reason} ->
        Logger.error("Error in sending message to bot, #{inspect reason}")
        :error
    end
  end

  def bot_endpoint() do
    facebook_chat_bot = Application.get_env(:elixirbot, :facebook_chat_bot)
    token = facebook_chat_bot.webhook_verify_token
    message_url = facebook_chat_bot.message_url
    base_url = facebook_chat_bot.base_url
    version = facebook_chat_bot.api_version
    token_path = "?access_token=#{token}"
    Path.join([base_url, version, message_url, token_path])
  end
end
