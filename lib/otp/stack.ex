defmodule Otp.Stack do
  use GenServer

  def init(initial_elements) do
    {:ok, initial_elements}
  end

  def handle_call(:pop, _requester_pid, []) do
    {:reply, :empty, []}
  end

  def handle_call(:pop, _requester_pid, [x | xs]) do
    {:reply, {:ok, x}, xs}
  end

  def handle_cast({:push, new_element}, current_state) do
    next_state = [new_element | current_state]
    {:noreply, next_state}
  end
end

# > {:ok,pid} = GenServer.start_link(Otp.Stack, [5,"cat",9], [debug: [:trace, :statistics]])
# > GenServer.call(pid, :pop)
# > GenServer.cast(pid, {:push, "Dog"})
# > GenServer.cast(pid, {:push, "Dog"})
