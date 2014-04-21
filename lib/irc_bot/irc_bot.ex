defmodule IrcBot do
  @moduledoc """
  Usage :
    IrcBot.start!
    {:ok, bot} = IrcBot.start_bot!

    # connect! <client> <host> <port=6667>
    IrcBot.Bot.connect! client, "irc.localhost", 6667 
  
    # login <client> <nick> <password> <username> <name>
    IrcBot.Bot.login client, "TheBot", "mypasswordhere", "user", "name"

    # join <client> <channel> <password="">
    IrcBot.join client, "#testbot"

    
  """
  use Supervisor.Behaviour

  @doc """
  Launches the supervisor
  """
  def start! do
    :supervisor.start_link({:local, :ircbot}, __MODULE__, [])
  end

  @doc """
  Start a new Bot
  """
  def start_bot! do
    :supervisor.start_child(:ircbot, worker(IrcBot.Bot, []))
  end
  
  @doc """
  Called by supervisor on `start_link`
  """
  def init(_) do
    supervise [], strategy: :one_for_one
  end

  # TEMP
  # defp foo do
  #   # read config etc
  #   config = [
  #     address: "irc.freenode.net",
  #     port: 6667,
  #     nickname: "tehsupratest"
  #   ]
  #   IO.puts "Starting (#{config[:address]}:#{config[:port]}@#{config[:nickname]}) ..."
  #   {:ok, socket} = IrcBot.Bot.connect(config)
  #   IO.puts "Connected"

  #   handle(socket)
  #   {:ok, []}
  # end

  # defp handle(socket) do
  #   receive do
  #     {:tcp, ^socket, data} ->
  #       App.handle(socket, data)
  #       handle(socket)
  #   end
  # end
end