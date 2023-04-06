defmodule Stack do
  @server Stack.Server
  alias Stack.Impl, as: S

  def start() do
    GenServer.start_link(@server, S.empty(), name: @server)
  end

  @spec start(any) :: :ignore | {:error, any} | {:ok, pid}
  def start(stack_elements) do
    GenServer.start_link(@server, S.create(stack_elements), name: @server)
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def top do
    GenServer.call(@server, :top)
  end

  @spec push(any) :: :ok
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
