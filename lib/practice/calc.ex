defmodule Practice.Calc do
  def tag_tokens(list) do
    Enum.map(list, fn x ->
    	if x == "+" || x == "*" || x == "-" || x == "/" do
    	   {:op, x}
    	else
    	   {:num, String.to_integer(x)}
      end
      end)
  end

  def divs_and_mults(tuple_list) do
    div_and_mul(tuple_list, [])
  end

  def adds_and_subs(tuple_list) do
    add_and_sub(tuple_list, [])
  end

  def divide_tuples({:num, x}, {:num, y}), do: [{:num, x / y}]
  def mult_tuples({:num, x}, {:num, y}), do: [{:num, x * y}]
  def add_tuples({:num, x}, {:num, y}), do: [{:num, x + y}]
  def sub_tuples({:num, x}, {:num, y}), do: [{:num, x - y}]

  def div_and_mul([], left_side), do: Enum.reverse(left_side)
  def div_and_mul([ {:op, "/"} | rest ], left_side), do: div_and_mul(tl(rest), divide_tuples(hd(left_side), hd(rest)) ++ tl(left_side))
  def div_and_mul([ {:op, "*"} | rest ], left_side), do: div_and_mul(tl(rest), mult_tuples(hd(left_side), hd(rest)) ++ tl(left_side))
  def div_and_mul([ {:op, "-"} | rest ] , left_side), do: div_and_mul(rest, [{:op, "-"}] ++ left_side)
  def div_and_mul([ {:op, "+"} | rest ] , left_side), do: div_and_mul(rest, [{:op, "+"}] ++ left_side)
  def div_and_mul([ {:num, x} | rest ] , left_side), do: div_and_mul(rest, [{:num, x}] ++ left_side)

  def add_and_sub([], left_side), do: Enum.reverse(left_side)
  def add_and_sub([ {:op, "+"} | rest ], left_side), do: add_and_sub(tl(rest), add_tuples(hd(left_side), hd(rest)) ++ tl(left_side))
  def add_and_sub([ {:op, "-"} | rest ], left_side), do: add_and_sub(tl(rest), sub_tuples(hd(left_side), hd(rest)) ++ tl(left_side))
  def add_and_sub([ {:num, x} | rest ] , left_side), do: add_and_sub(rest, [{:num, x}] ++ left_side)

  def get_num([{:num, x}]), do: x

  def calc(expr) do
     expr
     |> String.split
     |> tag_tokens
     |> divs_and_mults
     |> adds_and_subs
     |> get_num
  end
end
