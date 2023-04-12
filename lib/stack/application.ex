defmodule Stack.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Stash, Stack.Impl.create([1, 2, 3])},
      {Stack.Server, nil},
    ]
    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
