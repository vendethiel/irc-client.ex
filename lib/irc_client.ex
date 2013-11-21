defmodule IrcBot.Client do
  @moduledoc """
  IRC Bot, client
  """

  @doc """
  Start the bot.
  """
  def start(_type, _args) do
    # read config etc
    App.connect({
      :address, "irc.freenode.net",
      :port, 6667,
      :nickname, "test"
    })
  end
end
