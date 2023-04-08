defmodule Otp.Sequence do
  use GenServer

  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def current_number, do: GenServer.call(__MODULE__, :current_number)
  def next_number, do: GenServer.call(__MODULE__, :next_number)
  def prime_factors, do: GenServer.call(__MODULE__, :prime_factors)
  def increment_number(delta), do: GenServer.cast(__MODULE__, {:increment_number, delta})
  def set_number(new_number), do: GenServer.cast(__MODULE__, {:set_number, new_number})

  #####
  # GenServer implementation

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:current_number, _requester_pid, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_call(:next_number, _requester_pid, current_state) do
    next_state = current_state + 1
    {:reply, current_state, next_state}
  end

  def handle_call(:prime_factors, _requester_pid, current_state) do
    {:reply, {:prime_factors, current_state, Otp.PrimeFactors.factors(current_state)}, current_state}
  end

  def handle_call(any, _requester_pid, current_state) do
    {:reply, "Not handler found for #{any}", current_state}
  end

  def handle_cast({:increment_number, delta}, current_state) do
    next_state = current_state + delta
    {:noreply, next_state}
  end

  @spec handle_cast({:set_number, any}, any, any) :: {:noreply, any}
  def handle_cast({:set_number, new_number}, _requester_pid, _current_state) do
    next_state = new_number
    {:noreply, next_state}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and I'm happy"}]]
  end

  def handle_info(_info, _state) do
    next_state = 1_000_000
    {:noreply, next_state}
  end
end

# > {:ok,pid} = GenServer.start_link(Otp.Sequence, 100, [debug: [:trace, :statistics]])
# > GenServer.call(pid, :next_number)
# > GenServer.cast(pid, {:increment_number, 5})
# > :sys.statistics pid, :get
# > :sys.get_status pid
# > :sys.trace pid, false
# > :sys.statistics pid, false
