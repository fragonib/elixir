defmodule Sequence.PrimeFactors do
  def factors(num) do
    factors(num, 2, [])
      |> Enum.reverse()
  end

  defp factors(1, _, acc) do
    acc
  end

  defp factors(num, candidate, acc) when rem(num, candidate) == 0 do
    factors(div(num, candidate), candidate, [candidate | acc])
  end

  defp factors(num, candidate, acc) do
    factors(num, candidate + 1, acc)
  end
end
