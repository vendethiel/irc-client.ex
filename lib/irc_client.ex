defmodule IrcBot.Client do
  @moduledoc """
  IRC Bot, client
  """

  @doc """
  Start the bot.
  """
  def start(_type, _args) do
    # read config etc
    {:ok, socket} = App.connect({
      :address, "irc.freenode.net",
      :port, 6667,
      :nickname, "test"
    })

    handle(socket)
  end

  defp handle(socket) do
    receive do
      {:tcp, ^socket, data} ->
        App.handle(socket, data)
        handle(socket)
    end
  end
end
