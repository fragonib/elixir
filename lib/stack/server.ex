defmodule Stack.Server do
  use GenServer
  alias Stack.Impl, as: S

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _requester_pid, stack) do
    {:reply, {:ok, S.top(stack)}, S.pop(stack)}
  end

  def handle_call(:top, _requester_pid, stack) do
    {:reply, {:ok, S.top(stack)}, stack}
  end

  def handle_cast({:push, new_element}, stack) do
    {:noreply, S.push(new_element, stack)}
  end

  def handle_cast(:finish, stack) do
    {:stop, 'Request termination', stack}
  end

  def terminate(reason, state) do
    IO.puts(:stdio, "Reason: '#{reason}', State: '#{state}'")
  end
end
