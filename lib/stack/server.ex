defmodule Stack.Server do
  @server Stack.Server
  use GenServer
  alias Stack.Impl, as: S

  def start_link(initial_stack) do
    GenServer.start_link(@server, initial_stack, name: @server)
  end

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _requester_pid, stack) do
    {:reply, {:ok, S.top(stack)}, S.pop(stack)}
  end

  def handle_call(:top, _requester_pid, stack) do
    {:reply, {:ok, S.top(stack)}, stack}
  end

  def handle_call(:print, _requester_pid, stack) do
    {:reply, {:ok, inspect(stack)}, stack}
  end

  def handle_cast({:push, new_element}, stack) do
    if new_element > 10 do
      raise "oops"
    end
    {:noreply, S.push(new_element, stack)}
  end

  def handle_cast(:finish, stack) do
    {:stop, 'Request termination', stack}
  end

  def terminate(reason, state) do
    IO.puts(:stdio, "Reason: '#{inspect(reason)}', State: '#{inspect(state)}'")
  end
end
