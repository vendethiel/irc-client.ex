defmodule IrcBot.App do
  @moduledoc """
  IRC Bot, client
  """

  use Application.Behaviour

  @doc """
  Start the bot.
  """
  def start(_, _) do
    IrcBot.start!
  end
end
