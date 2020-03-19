defmodule Strain do
  @moduledoc """

    Author: Randall Shopoff
    Date: March, 16, 2020

  """
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)

  def keep(list, fun) do
    for x <- list, fun.(x), do: x
  end

  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    for x <- list, not fun.(x), do: x
  end
end
