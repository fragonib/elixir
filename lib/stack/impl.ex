defmodule Stack.Impl do

  def create(elements), do: elements
  def empty(), do: []

  def pop([]), do: []
  def pop([_x | xs]), do: xs

  def top([]), do: :empty
  def top([x | _xs]), do: x

  def push(new_element, stack), do: [new_element | stack]

  def repr(stack), do: "Stack: [#{Enum.join(stack, ", ")}]"

  def print(stack), do: IO.puts(Stack.Impl.repr(stack))

end
