defmodule Stack.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Stash, Application.get_env(:concurrency, :initial_stack)},
      {Stack.Server, nil},
    ]
    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
