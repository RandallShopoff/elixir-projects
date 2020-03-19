defmodule WordCount do
  @moduledoc """
  Author: Randall
  Date: March 15, 2020
  """
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    # Convert sentence to lower case.
    String.downcase(sentence)

    # Split the sentence into distinct words.
    # In the regexp below, the characters between []
    # will be removed and the words on either side of them
    # will be put into a list.
    |> String.split(~r/[^[:alnum:]-]/u, trim: true)

    # Once the words have been isolated from the
    # clutter, have Enum.frequencies return the counts.
    |> Enum.frequencies()
  end
end
