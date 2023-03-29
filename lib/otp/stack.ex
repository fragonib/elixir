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

  def handle_call({:push, new_element}, _requester_pid, current_state) do
    response = new_element
    next_state = [new_element | current_state]
    {:reply, response, next_state}
  end
end
