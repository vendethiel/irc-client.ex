defmodule IrcBot.Client do
  @moduledoc """
  IRC Bot, client
  """

  use Application.Behaviour

  @doc """
  Start the bot.
  """
  def start(:normal, []) do
    # read config etc
    config = [
      address: "irc.freenode.net",
      port: 6667,
      nickname: "tehsupratest"
    ]
    IO.puts "Starting (#{config[:address]}:#{config[:port]}@#{config[:nickname]}) ..."
    {:ok, socket} = IrcBot.App.connect(config)
    IO.puts "Connected"

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
