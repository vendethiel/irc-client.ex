defmodule IrcBot.Mixfile do
  use Mix.Project

  def project do
    [ app: :irc_client,
      version: "0.0.1",
      elixir: "~> 0.10.3",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { IrcBot.App, [] }]
  end

  defp deps do
    []
  end
end
