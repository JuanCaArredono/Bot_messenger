defmodule Elixirbot do
  @moduledoc """
  Elixirbot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Elixirbot.{Message, MessageHandler}
  def handle_event(event) do
    IO.inspect(Message.get_messaging(event) )
    case Message.get_messaging(event) do
      %{"message" => message} ->
        MessageHandler.handle_message(message, event)
      _ ->
        error_template = Elixirbot.Template.text(event, "Something went wrong. Our Engineers are working on it.")
        Elixirbot.Bot.send_message(event, error_template)
    end
  end
end
