defmodule NucleotideCount do
  @moduledoc """

    Author:   Randall Shopoff
    Date:     March 12, 2020

  """
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    # If the nucleotide is valid...
    if nucleotide in @nucleotides do
      # return the count for requested nucleotide
      histogram(strand)[nucleotide]
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    # Initialize histogram
    Map.new(@nucleotides, fn x -> {x, 0} end)

    # pipe newly created map into Map.merge...
    |> Map.merge(
      # Enum.frequencies gives count for distinct keys...
      Enum.frequencies(strand),

      # where common keys exist between initial and
      # frequency maps, add the values
      fn _k, v1, v2 ->
        v1 + v2
      end
    )
  end
end
