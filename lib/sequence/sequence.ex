defmodule Sequence.Server do
  use GenServer
  import Sequence.PrimeFactors

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:next_number, _requester_pid, current_state) do
    response = current_state
    next_state = current_state + 1
    {:reply, response, next_state}
  end

  def handle_call({:set_number, new_number}, _requester_pid, _current_state) do
    response = new_number
    next_state = new_number
    {:reply, response, next_state}
  end

  def handle_call({:factors, number}, _, _) do
    {:reply, {:factors_of, number, Sequence.PrimeFactors.factors(number)}, []}
  end
end
