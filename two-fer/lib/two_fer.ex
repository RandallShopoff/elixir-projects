defmodule TwoFer do
  @moduledoc """

    Author: Randall Shopoff
    Date:   March 17, 2020

  """
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "you") do
    # There are several cases to consider, but it boils down
    # to binary?

    # The empty string case is handled by adding a default
    # value of "you".
    if Kernel.is_binary(name),
      # Strings are binary...
      do: "One for #{name}, one for me",
      # everything else for the test are not
      else: raise(FunctionClauseError)
  end
end
