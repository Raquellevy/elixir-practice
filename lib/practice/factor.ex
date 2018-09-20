defmodule Practice.Factor do
  def factors(result, num, num2) do
    cond do
      num <= 1 ->
        result 
      rem(num, num2) == 0 ->
        factors(result ++ [num2], div(num, num2), num2)
      true -> 
        factors(result, num, num2+1)
      end
  end

  def factor(x) do
    factors([], x, 2)
  end
end
