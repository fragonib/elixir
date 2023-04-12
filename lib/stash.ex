defmodule Stash do
  use GenServer
  @me __MODULE__

  def start_link(state) do
    GenServer.start_link(@me, state, name: @me)
  end

  def get() do
    GenServer.call(@me, {:get})
  end

  def update(new_state) do
    GenServer.cast(@me, {:update, new_state})
  end

  # Server implementation
  def init(state) do
    {:ok, state}
  end

  def handle_call({:get}, _from, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_cast({:update, new_state}, _current_state) do
    {:noreply, new_state}
  end
end
