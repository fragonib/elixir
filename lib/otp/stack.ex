defmodule Otp.Stack do
  use GenServer

  def init(initial_elements) do
    {:ok, initial_elements}
  end

  def handle_call(:pop, _requester_pid, current_state) do
    response =
      case current_state do
        [] -> {:empty}
        [x | _] -> {:ok, x}
      end

    next_state =
      case current_state do
        [] -> []
        [_ | xs] -> xs
      end

    {:reply, response, next_state}
  end

  def handle_cast({:push, new_element}, current_state) do
    next_state = [new_element | current_state]
    {:noreply, next_state}
  end
end

# > {:ok,pid} = GenServer.start_link(Otp.Stack, [5,"cat",9], [debug: [:trace, :statistics]])
# > GenServer.call(pid, :pop)
# > GenServer.cast(pid, {:push, "Dog"})
