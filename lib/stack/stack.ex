defmodule Stack do
  @server Stack.Server

  def pop do
    GenServer.call(@server, :pop)
  end

  def top do
    GenServer.call(@server, :top)
  end

  def push(new_element) do
    GenServer.cast(@server, {:push, new_element})
  end

  def print() do
    GenServer.call(@server, :print)
  end

  def stop() do
    GenServer.cast(@server, :finish)
  end
end
