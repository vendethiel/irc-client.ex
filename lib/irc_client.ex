defmodule IrcBot.Client do
  @moduledoc """
  IRC Bot, client
  """

  @doc """
  Start the bot.
  """
  def start(:normal, []) do
    IO.puts "Starting ..."
    # read config etc
    config = [
      address: "irc.freenode.net",
      port: 6667,
      nickname: "test"
    ]
    {:ok, socket} = IrcBot.App.connect(config)

    handle(socket)
    :ok
  end

  defp handle(socket) do
    receive do
      {:tcp, ^socket, data} ->
        App.handle(socket, data)
        handle(socket)
    end
  end
end
