defmodule Otp.Sequence do
  use GenServer

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
    {:reply, {:factors_of, number, Otp.PrimeFactors.factors(number)}, []}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    next_state = current_number + delta
    {:noreply, next_state}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and I'm happy"}]]
  end
end

# > {:ok,pid} = GenServer.start_link(Otp.Sequence, 100, [debug: [:trace, :statistics]])
# > GenServer.cast(pid, { :increment_number, 5} )
# > GenServer.call(pid, :next_number)
# > GenServer.call(pid, :next_number)
# > :sys.statistics pid, :get
# > :sys.get_status pid
