defmodule Otp.Sequence do
  use GenServer

  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  #####
  # GenServer implementation

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:echo, requester_pid, current_state) do
    {:reply, requester_pid, current_state}
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

  def handle_call(any, _requester_pid, current_state) do
    {:reply, "Not found atom: #{any}", current_state}
  end

  def handle_cast({:increment_number, delta}, current_state) do
    next_state = current_state + delta
    {:noreply, next_state, 5000}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and I'm happy"}]]
  end

  def handle_info(_info, _state) do
    {:noreply, 1_000_000}
  end
end

# > {:ok,pid} = GenServer.start_link(Otp.Sequence, 100, [debug: [:trace, :statistics]])
# > GenServer.call(pid, :next_number)
# > GenServer.cast(pid, {:increment_number, 5})
# > :sys.statistics pid, :get
# > :sys.get_status pid
# > :sys.trace pid, false
# > :sys.statistics pid, false
