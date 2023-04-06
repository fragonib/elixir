defmodule Stack.Server do
    use GenServer
    alias Stack.Impl, as: S

    def init(stack) do
      {:ok, stack}
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
  end
