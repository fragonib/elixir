defmodule Stack.ImplTest do
  use ExUnit.Case
  doctest Stack.Impl
  alias Stack.Impl, as: Stack

  test "create new stack" do
    assert Stack.empty() == []
    assert Stack.create([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
  end

  test "should return new stack without head" do
    assert Stack.pop(Stack.create([])) == []
    assert Stack.pop(Stack.create([1, 2, 3])) == [2, 3]
  end

  test "should return top stack element" do
    assert Stack.top(Stack.create([])) == :empty
    assert Stack.top(Stack.create([1, 2, 3])) == 1
  end

  test "should add new elements on top of stack" do
    assert Stack.push(1, Stack.empty()) == [1]
    assert Stack.push(1, Stack.create([2, 3])) == [1, 2, 3]
  end

  test "should generate literal representation" do
    assert Stack.repr(Stack.create([])) == "Stack: []"
    assert Stack.repr(Stack.create([1, 2, 3])) == "Stack: [1, 2, 3]"
  end
end
