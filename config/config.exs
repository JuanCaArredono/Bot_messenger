# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixirbot,
  facebook_chat_bot: %{
    message_url: "me/messages",
    api_version: "v14.0",
    base_url: "https://graph.facebook.com",
    page_access_token: System.get_env("FACEBOOK_PAGE_ACCESS_TOKEN"),
    webhook_verify_token: System.get_env("FACEBOOK_WEBHOOK_VERIFY_TOKEN")
  }

# Configures the endpoint
config :elixirbot, ElixirbotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/87wwG5mpDY5QKj8+m58aaKi8wli7NeP8UjBUKR9BeDoIv68hs6EjD2w0YTncewD",
  render_errors: [view: ElixirbotWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Elixirbot.PubSub,
  live_view: [signing_salt: "dgIbYwj3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
