defmodule SequenceTest do
  use ExUnit.Case
  doctest Otp.PrimeFactors
  alias Otp.PrimeFactors, as: PrimeFactors

  test "calculate prime factors" do
    assert PrimeFactors.factors(10) == [2,5]
  end
end
