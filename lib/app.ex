defmodule IrcBot.App do
  @moduledoc """
  Client App
  """

  use Application.Behaviour

  @doc """
  Connects to a given server
  """
  def connect({:address, address, :port, port, :nickname, nickname}) do
    case :gen_tcp.connect(address, port, [{:packet, :line}]) do
      {:ok, socket} ->
        IO.puts("Connected. Logging in ...")
        send(socket, "NICK", nickname)
        send(socket, "USER", [nickname, address, "alsotodo", ":irc-client"])
        IO.puts("Logged as in #{nickname}.")

        {:ok, socket}

      {:error, reason} ->
        IO.puts("Connection refused : " <> reason)

        {:error, reason}
    end
  end

  @doc """
  closes the connection
  """
  def close(socket) do
    # random voodo magic
    case :int.peername(socket) do
      {:ok, _} ->
        IO.puts("Connection closed.")
        :ok

      {:error, reason} ->
        IO.puts("Error while closing the connection :")
        IO.puts(reason)
        :error
    end
  end
  
  defp send(s, opcode, msg) when is_list(msg) do
    send(s, opcode, join_strings(msg))
    :ok
  end

  defp send(s, opcode, msg) do
    :gen_tcp.send(s, opcode <> " " <> msg <> "\r\n")
    :ok
  end

  defp join_strings(strs, glue // " ") do
    Enum.reduce(strs, fn(str, acc) ->
      acc <> (if acc, do: glue, else: "") <> str
    end)
  end
end