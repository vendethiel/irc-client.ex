defmodule IrcBot do
  @doc """
  Launches the supervisor
  """
  def start! do
    :supervisor.start_link({:local, :exirc}, __MODULE__, [])
    {:ok, []}
  end
  
  @doc """
  Called by supervisor on `start_link`
  """
  def init(_) do
    # read config etc
    config = [
      address: "irc.freenode.net",
      port: 6667,
      nickname: "tehsupratest"
    ]
    IO.puts "Starting (#{config[:address]}:#{config[:port]}@#{config[:nickname]}) ..."
    {:ok, socket} = IrcBot.Bot.connect(config)
    IO.puts "Connected"

    handle(socket)
    {:ok, []}
  end

  defp handle(socket) do
    receive do
      {:tcp, ^socket, data} ->
        App.handle(socket, data)
        handle(socket)
    end
  end
end