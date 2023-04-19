defmodule Fib do
  def of(0), do: 0
  def of(1), do: 1
  def of(n), do: Fib.of(n - 1) + Fib.of(n - 2)
end

defmodule Tasks.Fib do
  use Task

  def start_link(param) do
    Task.start_link(__MODULE__, :fib_task, [param])
  end

  def fib_task(param) do
    IO.puts("The result is #{Fib.of(param)}")
  end
end

# Use task API to launch funs async
#IO.puts("Start the task")
#worker = Task.async(Fib, :of, [2000])
#IO.puts("Do something else")
#IO.puts("Wait for the task")
#result = Task.await(worker)
#IO.puts("The result is #{result}")

# Use Supervisor to launch task API to launch funs async
children = [{Tasks.Fib, 2000}]
Supervisor.start_link(children, strategy: :one_for_one)
