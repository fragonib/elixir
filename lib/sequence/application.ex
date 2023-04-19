defmodule Sequence.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Stash, Application.get_env(:concurrency, :initial_number)},
      {Sequence.Server, nil},
    ]
    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
