defmodule SequenceTest do
  use ExUnit.Case
  doctest Sequence.PrimeFactors
  alias Sequence.PrimeFactors, as: PrimeFactors

  test "calculate prime factors" do
    assert PrimeFactors.factors(10) == [2,5]
  end
end
