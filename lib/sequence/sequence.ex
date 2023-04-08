defmodule Sequence.Server do
  use GenServer
  @me __MODULE__

  #####
  # External API

  def start_link(_) do
    GenServer.start_link(@me, nil, name: @me)
  end

  def next_number do
    GenServer.call(@me, :next_number)
  end

  def set_number(new_number) do
    GenServer.cast(@me, {:set_number, new_number})
  end

  def increment_number(delta) do
    GenServer.cast(@me, {:increment_number, delta})
  end

  #####
  # GenServer implementation

  def init(_) do
    {:ok, Sequence.Stash.get()}
  end

  def handle_call(:echo, requester_pid, current_state) do
    {:reply, requester_pid, current_state}
  end

  def handle_call(:next_number, _requester_pid, current_state) do
    response = current_state
    next_state = current_state + 1
    {:reply, response, next_state}
  end

  def handle_cast({:set_number, new_number}, _current_state) do
    {:noreply, new_number}
  end

  def handle_cast({:increment_number, delta}, current_state) do
    next_state = current_state + delta
    {:noreply, next_state}
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.update(current_number)
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and I'm happy"}]]
  end
end
