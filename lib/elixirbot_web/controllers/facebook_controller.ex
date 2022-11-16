defmodule ElixirbotWeb.FacebookController do
  use ElixirbotWeb, :controller
  alias Elixirbot.Bot
  def verify_webhook_token(conn, params) do
    verified? = Bot.verify_webhook(params)
    if verified? do
      conn
        |> put_resp_content_type("application/json")
        |> resp(200, params["hub.challenge"])
        |> send_resp()
      else
        conn
        |> put_resp_content_type("application/json")
        |> resp(403, Jason.encode!(%{status: "error", message: "unauthorized"}))
    end
  end

  def handle_event(conn, event_data) do
    Elixirbot.handle_event(event_data)
    conn
    |> put_resp_content_type("application/json")
    |> resp(200, Jason.encode!(%{status: "ok"}))
  end
end
