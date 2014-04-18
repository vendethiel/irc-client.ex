defmodule IrcBot.App do
  @moduledoc """
  IRC Bot, client
  """
  use Application.Behaviour

  @doc """
  Start the bot.
  """
  def start(_type, _args) do
    IrcBot.start!
  end
end
