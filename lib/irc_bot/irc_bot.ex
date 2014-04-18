defmodule IrcBot do
  use Supervisor.Behaviour

  @doc """
  Launches the supervisor
  """
  def start! do
    :supervisor.start_link({:local, :ircbot}, __MODULE__, [])
    #:gen_server.start_link(__MODULE__, [], [])
    #{:ok, []}
  end

  @doc """
  Start a new Bot
  """
  def start_client do
    :supervisor.start_child(:ircbot, worker(IrcBot.Bot, []))
  end
  
  @doc """
  Called by supervisor on `start_link`
  """
  def init(_) do
    supervise [], strategy: :one_for_one
  end

  # TEMP
  defp foo do
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