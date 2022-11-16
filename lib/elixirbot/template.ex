defmodule Elixirbot.Template do
  alias Elixirbot.Message
  def text(event, text) do
     %{"recipient" => %{
          "id" => Message.get_sender(event)["id"]
          },
       "message" => %{"text" => text }
      }
  end
 end
